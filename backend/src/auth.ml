module Query = struct
  open Caqti_request.Infix
  open Caqti_type.Std

  let find_user =
    tup2 string string ->? string @@
    "SELECT id FROM users WHERE username = ? AND password = ?"
end

module Run_query = struct
  open Lwt.Infix

  let find_user username password =
    let%lwt user = Sihl.Database.find_opt Query.find_user (username, password) in

    Lwt.return user >>= function
    | Some user_id ->
      let json = `Assoc [("message", `String ("Hello, " ^ user_id))] in
      Opium.Response.of_json json |> Lwt.return
    | None -> Utils.error 401 "unauthorized" "invalid username or password"
end

module Models = struct
  type user = {
    username : string;
    password : string;
  } [@@deriving yojson]
end

(* FIXME: error 500 (Yojson.Json_error) when Multipart Form sent *)
let post_login (req : Rock.Request.t) : Rock.Response.t Lwt.t =
  try
    let%lwt body = Opium.Request.to_json_exn req in
    let json = Models.user_of_yojson body in
    Run_query.find_user json.username json.password
  with _ -> Utils.error 400 "invalid request" "invalid json body"
