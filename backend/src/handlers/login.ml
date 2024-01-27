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
    username : string; [@regex "/^[a-zA-Z0-9_]{4,16}$/"]
    password : string; [@regex "/^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[@$!%*#?&])[A-Za-z0-9@$!%*#?&]{8,20}$/"]
  } [@@deriving yojson, validate]
end

(* shorthands *)
module Session = Sihl.Web.Session
module DB = Sihl.Database
module V = Common.Validation
module Q = Query
module M = Models

let login req =
  let logic (json : M.user) =
    let%lwt user = DB.find_opt Q.find_user (json.username, json.password) in
    match user with
    | Some user_id ->
      session_return 200 [
        ("message",   "login successful");
        ("id",        user_id);
        ("username",  json.username);
      ] [
        ("id",        user_id);
        ("username",  json.username);
      ]
    | None -> error 401 "unauthorized" "invalid username or password"
  in try
    logic
    (* |> V.validate_schema M.validate_user *)
    |> V.validate_model M.user_of_yojson
    |> V.validate_json req
  with _ -> error 400 "invalid request" "generic error, please report this"

let logout _ = session_return 200 [("message", "logout successful")] []

let verify _ = return 200 [("message", "valid login")]
