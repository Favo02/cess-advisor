(* customize Sihl set cookie Session utility to include Max-Age, SameSite, Secure and HttpOnly *)

(* from session.ml file: https://github.com/oxidizing/sihl/blob/master/sihl/src/session.ml *)

module StrMap = Map.Make (String)

let to_yojson session =
  `Assoc (
    session
      |> StrMap.to_seq
      |> List.of_seq
      |> List.map (fun (k, v) -> k, `String v))

let to_json session = session |> to_yojson |> Yojson.Safe.to_string

(* from web_session.ml file: https://github.com/oxidizing/sihl/blob/master/sihl/src/web_session.ml *)

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
  let session = session |> List.to_seq |> StrMap.of_seq in
  let cookie_value = to_json session in
  let cookie = cookie_key, cookie_value in
  let same_site = match same_site with | "strict" -> `Strict | "lax" -> `Lax | _ -> `None in
  Opium.Response.add_cookie_or_replace
    ~sign_with:signed_with
    ~expires:(`Max_age max_age)
    ~scope:(Uri.of_string scope)
    ~same_site:same_site
    ~secure:true
    ~http_only:http_only
    cookie
    resp
