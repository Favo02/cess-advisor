open Common.Utils

module Query = struct
  open Caqti_request.Infix
  open Caqti_type.Std

  let create =
    tup3 (tup4 string string int string) (tup4 bool bool bool bool) (tup2 int int) ->. unit @@
    "INSERT INTO reviews (author, toilet, rating, description, paper, soap, dryer, hotwater, clean, temperature) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
end

module Models = struct
  type get = { (* FIXME *)
    id            : string;
    author        : string;
    date          : string;
    toilet        : string;
    rating        : int;
    description   : string;
  } [@@deriving yojson] (* no need to validate, read from db *)

  type create = {
    toilet        : string;  [@uuid]
    rating        : int;     [@greater_than_or_equal 0] [@less_than_or_equal 10]
    description   : string;  [@regex "^[\t\n\x20-\xFF]{6,250}$"]
    paper         : bool;
    soap          : bool;
    dryer         : bool;
    hotwater      : bool;
    clean         : int;     [@greater_than_or_equal 0] [@less_than_or_equal 10]
    temperature   : int;     [@greater_than_or_equal 0] [@less_than_or_equal 10]
  } [@@deriving yojson, validate]
end

(* shorthands *)
module Session = Sihl.Web.Session
module DB = Sihl.Database
module V = Common.Validation
module Q = Query
module M = Models

(* TODO: add get last reviews *)

(* TODO: add get toilet reviews *)

let create req =
  let logic (json : M.create) =
    match Session.find "id" req with
    | None -> error 400 "invalid request" "no session id found"
    | Some author ->
      let%lwt () = DB.exec Q.create ((author, json.toilet, json.rating, json.description), (json.paper, json.soap, json.dryer, json.hotwater), (json.clean, json.temperature)) in
      return 200 [("message", "review created")]
  in try%lwt
    logic
    |> V.validate_schema M.validate_create
    |> V.validate_model M.create_of_yojson
    |> V.validate_json req
  with _ -> error 400 "invalid request" "generic error, please report this"
