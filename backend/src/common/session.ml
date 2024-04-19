(*
Modified versions of Opium set cookie and Sihl sessions:

- Opium:
  Cookie.add_cookie_or_replace takes same_site as argument, but this is
  never applied to the cookie (probably a bug), so I added it to the function that
  generates the cookie header (Cookie.to_set_cookie_header)

- Sihl:
  Max-Age, SameSite, Secure and HttpOnly cookie options are not available to be set
  in Web.Session.set, so I added them and forwarded them to Opium.Response.add_cookie_or_replace

PRs have already been opened for both issues, waiting for approval
*)

(* Opium *)

let to_set_cookie_header (t : Opium.Cookie.t) =
  let v = Printf.sprintf "%s=%s" (fst t.value) (snd t.value) in
  let v =
    match Uri.path t.scope with
    | "" -> v
    | path -> Printf.sprintf "%s; Path=%s" v path
  in
  let v =
    match Uri.host t.scope with
    | None -> v
    | Some domain -> Printf.sprintf "%s; Domain=%s" v domain
  in
  let v =
    match t.same_site with
    | `None -> Printf.sprintf "%s; SameSite=None" v
    | `Strict -> Printf.sprintf "%s; SameSite=Strict" v
    | `Lax -> Printf.sprintf "%s; SameSite=Lax" v
  in
  let v =
    match t.expires with
    | `Date ptime ->
      Printf.sprintf "%s; Expires=%s" v (Ptime.to_date_time ptime |> Session_deps.Opium_Date.serialize)
    | `Max_age max -> Printf.sprintf "%s; Max-Age=%s" v (Int64.to_string max)
    | `Session -> v
  in
  let v = if t.secure then Printf.sprintf "%s; Secure" v else v in
  let v = if t.http_only then Printf.sprintf "%s; HttpOnly" v else v in
  "Set-Cookie", v

let add_cookie_or_replace ?sign_with ?expires ?scope ?same_site ?secure ?http_only value (t : Opium.Response.t)
  =
  let cookie_header =
    Opium.Cookie.make ?sign_with ?expires ?scope ?same_site ?secure ?http_only value
    |> to_set_cookie_header
  in
  let headers : Opium.Cookie.header list =
    Session_deps.Opium_List.replace_or_add
      ~f:(fun (k, v) _ ->
        match k, v with
        | k, v
          when String.equal (String.lowercase_ascii k) "set-cookie"
                && Session_deps.Opium_String.is_prefix v ~prefix:(fst value) -> true
        | _ -> false)
      cookie_header
      (Opium.Headers.to_list t.headers)
  in
  { t with headers = Opium.Headers.of_list headers }

(* Sihl *)

let set_cookie
  ?(cookie_key = "_session")
  ?(secret = Sihl.Configuration.read_secret ())
  ?(max_age = 3600L)
  ?(scope = "/")
  ?(same_site = "strict")
  ?(http_only = true)
  session
  resp
  =
  let signed_with = Opium.Cookie.Signer.make secret in
  let session = session |> List.to_seq |> Session_deps.Sihl_StrMap.of_seq in
  let cookie_value = Session_deps.sihl_to_json session in
  let cookie = cookie_key, cookie_value in
  let same_site = match same_site with | "strict" -> `Strict | "lax" -> `Lax | _ -> `None in
  add_cookie_or_replace
    ~sign_with:signed_with
    ~expires:(`Max_age max_age)
    ~scope:(Uri.of_string scope)
    ~same_site:same_site
    ~secure:true
    ~http_only:http_only
    cookie
    resp
