open Common.Utils

module Query = struct
  open Caqti_request.Infix
  open Caqti_type.Std

  let create =
    tup2 (tup4 string string string int) string ->. unit @@
    "INSERT INTO reviews (author, date, toilet, rating, description) VALUES (?, ?, ?, ?, ?)"
end

module Models = struct
  type get = {
    id               : string;
    author           : string;
    date             : string;
    toilet           : string;
    rating           : int;
    description      : string;
  } [@@deriving yojson]

  type create = {
    toilet           : string;  [@uuid]
    rating           : int;     [@greater_than 0]
    description      : string;  [@regex ""]
  } [@@deriving yojson, validate]
end

(* shorthands *)
module Session = Sihl.Web.Session
module DB = Sihl.Database
module V = Common.Validation
module Q = Query
module M = Models

let create req =
  let logic (json : M.create) =
    let date = current_date () in
    match Session.find "id" req with
    | None -> error 400 "invalid request" "no session id found"
    | Some author ->
      let%lwt () = DB.exec Q.create ((author, date, json.toilet, json.rating), json.description) in
      return 200 [("message", "review created")]
  in try
    logic
    (* |> V.validate_schema M.validate_create *)
    |> V.validate_model M.create_of_yojson
    |> V.validate_json req
  with _ -> error 400 "invalid request" "generic error, please report this"
