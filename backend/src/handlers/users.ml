open Common.Utils

module Query = struct
  open Caqti_request.Infix
  open Caqti_type.Std

  let me =
    string ->! tup2
      (tup2 string string)
      (tup3 int int (option float)) @@
    "SELECT
      u.id, u.username,
      COUNT(DISTINCT t.id) AS toilets_created,
      COUNT(DISTINCT r.id) AS reviews_authored,
      AVG(r.rating) AS average_review_rating
    FROM users u
    LEFT JOIN toilets t ON u.id = t.creator
    LEFT JOIN reviews r ON u.id = r.author
    WHERE u.id = ?
    GROUP BY u.id, u.username"

  let check_username_free =
    string ->! bool @@
    "SELECT EXISTS (SELECT * FROM users WHERE username = ?)"

  let create_user =
    tup2 string string ->! string @@
    "INSERT INTO users (username, password) VALUES (?, ?) RETURNING id"
end

module Models = struct
  type me = {
    user_id               : string;
    username              : string;
    toilets_created       : int;
    reviews_authored      : int;
    average_review_rating : float option;
  } [@@deriving yojson] (* no need to validate, read from db *)

  type create = {
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

let me req =
  let logic _ =
    match Session.find "id" req with
    | None -> error 400 "invalid request" "no session id found"
    | Some id ->
      let%lwt
        (user_id, username),
        (toilets_created, reviews_authored, average_review_rating)
      = DB.find Q.me id in
      M.yojson_of_me M.({
        user_id; username;
        toilets_created; reviews_authored; average_review_rating;
      })
      |> return_json 200
  in try%lwt
    logic ()
  with _ -> error 400 "invalid request" "generic error, please report this"

let create req =
  let logic (json : M.create) =
    let%lwt username_taken = DB.find Q.check_username_free json.username in
    match username_taken with
    | false ->
      let password_hash = Bcrypt.string_of_hash (Bcrypt.hash json.password) in
      let%lwt user_id = DB.find Q.create_user (json.username, password_hash) in
      session_return 201 [
        ("message",     "user created");
        ("id",          user_id);
        ("username",    json.username);
      ] [
        ("id",          user_id);
        ("username",    json.username);
        ("expiration",  expiration ~seconds:86400 ());
      ]
    | _ -> error 400 "invalid username" "username already taken"
  in try%lwt
    logic
    |> V.validate_schema M.validate_create
    |> V.validate_model M.create_of_yojson
    |> V.validate_json req
  with _ -> error 400 "invalid request" "generic error, please report this"
