open Common.Utils

module Query = struct
  open Caqti_request.Infix
  open Caqti_type.Std

  let find_user =
    tup2 string string ->? string @@
    "SELECT id FROM users WHERE username = ? AND password = ?"
end

module Models = struct
  type user = {
    username : string;
    password : string;
  } [@@deriving yojson]
end

(* shorthands *)
module DB = Sihl.Database
module Q = Query

(* FIXME: error 500 (Yojson.Json_error) when Multipart Form sent *)
let login req =
  try
    let%lwt body = Opium.Request.to_json_exn req in
    let body_json = Models.user_of_yojson body in

    let%lwt user = DB.find_opt Q.find_user (body_json.username, body_json.password) in
    match user with
    | Some user_id ->
      session_return 200 [
        ("message",   "login successful");
        ("id",        user_id);
        ("username",  body_json.username);
      ] [
        ("id",        user_id);
        ("username",  body_json.username);
      ]

    | None -> error 401 "unauthorized" "invalid username or password"
  with _ -> invalid_request ()

let logout _ = session_return 200 [("message", "logout successful")] []

let verify _ = return 200 [("message", "valid login")]
