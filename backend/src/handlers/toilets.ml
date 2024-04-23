open Common.Utils

module Query = struct
  open Caqti_request.Infix
  open Caqti_type.Std

  let get =
    string ->! tup3
      (tup4 string string string string)
      (tup4 string string string string)
      (tup3 string (option float) int) @@
    "SELECT
      t.id, u.username AS creator_name, t.creator AS creator_id, t.creation AS creation_date,
      t.title, t.university, t.building, t.place, t.description,
      AVG(r.rating) AS rating, COUNT(r.rating) as reviews_count
    FROM toilets t
    INNER JOIN users u ON t.creator = u.id
    LEFT JOIN reviews r ON t.id = r.toilet
    WHERE t.id = ?
    GROUP BY t.id, u.username"

  let get_all =
    unit ->* tup3
      (tup4 string string string string)
      (tup4 string string string string)
      (tup3 string (option float) int) @@
    "SELECT
      t.id, u.username AS creator_name, t.creator AS creator_id, t.creation AS creation_date,
      t.title, t.university, t.building, t.place, t.description,
      AVG(r.rating) AS rating, COUNT(r.rating) as reviews_count
    FROM toilets t
    INNER JOIN users u ON t.creator = u.id
    LEFT JOIN reviews r ON t.id = r.toilet
    GROUP BY t.id, u.username
    ORDER BY reviews_count DESC"

  let create =
    tup2
      (tup3 string string string)
      (tup3 string string string)
    ->. unit @@
    "INSERT INTO toilets
      (creator, title, university, building, place, description)
    VALUES (?, ?, ?, ?, ?, ?)"
end

module Models = struct
  type get = {
    id            : string;
    creator_name  : string;
    creator_id    : string;
    creation_date : string;
    title         : string;
    university    : string;
    building      : string;
    place         : string;
    description   : string;
    rating        : float option;
    reviews_count : int;
  } [@@deriving yojson] (* no need to validate, read from db *)

  type create = {
    title       : string; [@regex "^[\t\n\x20-\xFF]{6,50}$"]
    university  : string; [@regex "^[\t\n\x20-\xFF]{6,50}$"]
    building    : string; [@regex "^[\t\n\x20-\xFF]{6,50}$"]
    place       : string; [@regex "^[\t\n\x20-\xFF]{6,50}$"]
    description : string; [@regex "^[\t\n\x20-\xFF]{6,250}$"]
  } [@@deriving yojson, validate]
end

(* shorthands *)
module Session = Sihl.Web.Session
module DB = Sihl.Database
module V = Common.Validation
module Q = Query
module M = Models

let get req =
  let logic toilet_id =
    let%lwt
      (id, creator_name, creator_id, creation_date),
      (title, university, building, place),
      (description, rating, reviews_count)
    = DB.find Q.get toilet_id in
    M.yojson_of_get M.({
      id; creator_name; creator_id; creation_date;
      title; university; building; place;
      description; rating; reviews_count;
    })
    |> return_json 200
  in try%lwt
    logic
    |> V.validate_uuid_param (Opium.Router.param req "toilet")
  with _ -> error 400 "invalid request" "generic error, please report this"

let get_all _ =
  let logic () =
    let%lwt toilets = DB.collect Q.get_all () in
    List.map (fun (
      (id, creator_name, creator_id, creation_date),
      (title, university, building, place),
      (description, rating, reviews_count)
    ) -> M.yojson_of_get M.({
      id; creator_name; creator_id; creation_date;
      title; university; building; place;
      description; rating; reviews_count;
    })) toilets
    |> return_json_list 200
  in try%lwt
    logic ()
  with _ -> error 400 "invalid request" "generic error, please report this"

let create req =
  let logic (json : M.create) =
    match Session.find "id" req with
    | None -> error 400 "invalid request" "no session id found"
    | Some creator ->
      let%lwt () = DB.exec Q.create (
        (creator, json.title, json.university),
        (json.building, json.place, json.description)
      ) in
      return 200 [("message", "toilet created")]
  in try%lwt
    logic
    |> V.validate_schema M.validate_create
    |> V.validate_model M.create_of_yojson
    |> V.validate_json req
  with _ -> error 400 "invalid request" "generic error, please report this"
