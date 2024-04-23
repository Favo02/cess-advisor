open Common.Utils

module Query = struct
  open Caqti_request.Infix
  open Caqti_type.Std

  let find_user =
    string ->? tup2 string string @@
    "SELECT
      u.id, u.password
    FROM cessadvisor.users u
    WHERE u.username = ?"
end

module Models = struct
  type login = {
    username : string; [@regex "^[a-zA-Z0-9]{4,16}$"]
    password : string; [@custom Common.Validation.custom_password]
  } [@@deriving yojson, validate]
end

(* shorthands *)
module Session = Sihl.Web.Session
module DB = Sihl.Database
module V = Common.Validation
module Q = Query
module M = Models

let login req =
  let logic (json : M.login) =
    let%lwt user = DB.find_opt Q.find_user json.username in
    match user with
    | None -> error 401 "unauthorized" "invalid username or password"
    | Some (user_id, password) ->
      match Bcrypt.verify json.password (Bcrypt.hash_of_string password) with
      | false -> error 401 "unauthorized" "invalid username or password"
      | true -> session_return 200 [
          ("message",     "login successful");
          ("id",          user_id);
          ("username",    json.username);
        ] [
          ("id",          user_id);
          ("username",    json.username);
          ("expiration",  expiration ~seconds:86400 ());
        ]
  in try%lwt
    logic
    |> V.validate_schema M.validate_login
    |> V.validate_model M.login_of_yojson
    |> V.validate_json req
  with _ -> error 400 "invalid request" "generic error, please report this"

let logout _ = session_return ~max_age:0L 200 [("message", "logout successful")] []

let verify _ = return 200 [("message", "valid login")]
