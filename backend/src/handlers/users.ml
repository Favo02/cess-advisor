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
    username : string;
    password : string;
  } [@@deriving yojson]
end

(* shorthands *)
module DB = Sihl.Database
module Q = Query

let me req =
  let id = Sihl.Web.Session.find "id" req in
  let username = Sihl.Web.Session.find "username" req in
  match id, username with
  | Some user_id, Some username -> return 200 [
      ("id", user_id);
      ("username", username)
    ]
  | _ -> unauthorized ()

let create req =
  try
    let%lwt body = Opium.Request.to_json_exn req in
    let body_json = Models.user_of_yojson body in

    let%lwt username_valid = DB.find Q.check_username_free body_json.username in
    match username_valid with
    | false ->
      (* TODO: create Session.set util, like return utility *)
      let%lwt user_id = DB.find Q.create_user (body_json.username, body_json.password) in
      let json = `Assoc [
        ("message",   `String "user created");
        ("id",        `String user_id);
        ("username",  `String body_json.username);
      ] in
      Sihl.Web.Session.set [
        ("id",        user_id);
        ("username",  body_json.username);
      ] (Opium.Response.of_json json)
      |> Lwt.return

    | _ -> error 400 "invalid username" "username already taken"
  with _ -> invalid_request ()
