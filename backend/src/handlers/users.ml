open Common.Utils

module Query = struct
  open Caqti_request.Infix
  open Caqti_type.Std

  let check_username_free =
    string ->! bool @@
    "SELECT EXISTS (SELECT * FROM users WHERE username = ?)"

  let create_user =
    tup2 string string ->! string @@
    "INSERT INTO users (username, password) VALUES (?, ?) RETURNING id"
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

let me req =
  let id = Session.find "id" req in
  let username = Session.find "username" req in
  match id, username with
  | Some user_id, Some username -> return 200 [
      ("id", user_id);
      ("username", username)
    ]
  | _ -> error 401 "unauthorized" "not logged in"

let create req =
  let logic (json : M.user) =
    let%lwt username_valid = DB.find Q.check_username_free json.username in
    match username_valid with
    | false ->
      let%lwt user_id = DB.find Q.create_user (json.username, json.password) in
      session_return 201 [
        ("message",     "user created");
        ("id",          user_id);
        ("username",    json.username);
      ] [
        ("id",          user_id);
        ("username",    json.username);
        ("expiration",  expiration ());
      ]
    | _ -> error 400 "invalid username" "username already taken"
  in try
    logic
    (* |> V.validate_schema M.validate_user *)
    |> V.validate_model M.user_of_yojson
    |> V.validate_json req
  with _ -> error 400 "invalid request" "generic error, please report this"
