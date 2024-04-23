open Common.Utils

module Query = struct
  open Caqti_request.Infix
  open Caqti_type.Std

  let get_all =
    unit ->* tup3
      (tup2 (tup3 string string string) (tup3 string string string))
      (tup3 string string string)
      (tup2 (tup4 int string bool bool) (tup4 bool bool int int)) @@
    "SELECT
      r.id, t.id AS toilet_id, t.title, t.university, t.place, t.building,
      r.author AS author_id, u.username AS author_name, r.date,
      r.rating, r.description, r.paper, r.soap, r.dryer, r.hotwater, r.clean, r.temperature
    FROM cessadvisor.reviews r
    INNER JOIN cessadvisor.toilets t ON r.toilet = t.id
    INNER JOIN cessadvisor.users u ON r.author = u.id
    ORDER BY date DESC"

  let create =
    tup3
      (tup4 string string int string)
      (tup4 bool bool bool bool)
      (tup2 int int)
    ->. unit @@
    "INSERT INTO cessadvisor.reviews
      (author, toilet, rating, description, paper, soap, dryer, hotwater, clean, temperature)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"

  let get_by_toilet =
    string ->* tup3
      (tup2 (tup3 string string string) (tup3 string string string))
      (tup3 string string string)
      (tup2 (tup4 int string bool bool) (tup4 bool bool int int)) @@
    "SELECT
      r.id, t.id AS toilet_id, t.title, t.university, t.place, t.building,
      r.author AS author_id, u.username AS author_name, r.date,
      r.rating, r.description, r.paper, r.soap, r.dryer, r.hotwater, r.clean, r.temperature
    FROM cessadvisor.reviews r
    INNER JOIN cessadvisor.toilets t ON r.toilet = t.id
    INNER JOIN cessadvisor.users u ON r.author = u.id
    WHERE t.id = ?"
end

module Models = struct
  type get = {
    id            : string;
    toilet_id     : string;
    title         : string;
    university    : string;
    place         : string;
    building      : string;
    author_id     : string;
    author_name   : string;
    date          : string;
    rating        : int;
    description   : string;
    paper         : bool;
    soap          : bool;
    dryer         : bool;
    hotwater      : bool;
    clean         : int;
    temperature   : int;
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

let get_all _ =
  let logic () =
    let%lwt toilets = DB.collect Q.get_all () in
    List.map (fun (
      ((id, toilet_id, title), (university, place, building)),
      (author_id, author_name, date),
      ((rating, description, paper, soap), (dryer, hotwater, clean, temperature))
    ) -> M.yojson_of_get M.({
      id; toilet_id; title; university; place; building;
      author_id; author_name; date;
      rating; description; paper; soap; dryer; hotwater; clean; temperature
    })) toilets
    |> return_json_list 200
  in try%lwt
    logic ()
  with _ -> error 400 "invalid request" "generic error, please report this"

let create req =
  let logic (json : M.create) =
    match Session.find "id" req with
    | None -> error 400 "invalid request" "no session id found"
    | Some author ->
      let%lwt () = DB.exec Q.create (
        (author, json.toilet, json.rating, json.description),
        (json.paper, json.soap, json.dryer, json.hotwater),
        (json.clean, json.temperature)
      ) in
      return 200 [("message", "review created")]
  in try%lwt
    logic
    |> V.validate_schema M.validate_create
    |> V.validate_model M.create_of_yojson
    |> V.validate_json req
  with _ -> error 400 "invalid request" "generic error, please report this"

let get_by_toilet req =
  let logic toilet_id =
    let%lwt toilets = DB.collect Q.get_by_toilet toilet_id in
    List.map (fun (
      ((id, toilet_id, title), (university, place, building)),
      (author_id, author_name, date),
      ((rating, description, paper, soap), (dryer, hotwater, clean, temperature))
    ) -> M.yojson_of_get M.({
      id; toilet_id; title; university; place; building;
      author_id; author_name; date;
      rating; description; paper; soap; dryer; hotwater; clean; temperature
    })) toilets
    |> return_json_list 200
  in try%lwt
    logic
    |> V.validate_uuid_param (Opium.Router.param req "toilet")
  with _ -> error 400 "invalid request" "generic error, please report this"
