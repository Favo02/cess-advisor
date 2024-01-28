open Common.Utils

module Query = struct
  open Caqti_request.Infix
  open Caqti_type.Std

  let get_all =
    unit ->* tup2 (tup4 string string string int) string @@
    "SELECT id, name, place, floor, creator FROM toilets"

  let create =
    tup4 string string int string ->. unit @@
    "INSERT INTO toilets (name, place, floor, creator) VALUES (?, ?, ?, ?)"
end

module Models = struct
  type toilet = {
    id      : string; [@uuid]
    name    : string; [@regex ""]
    place   : string; [@regex ""]
    floor   : int;    [@greater_than -3]
    creator : string; [@uuid]
  } [@@deriving yojson, validate]

  type create = {
    name    : string; [@regex ""]
    place   : string; [@regex ""]
    floor   : int;    [@greater_than -3]
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
    List.map (fun ((id, name, place, floor), creator) ->
      M.yojson_of_toilet M.({ id; name; place; floor; creator; })
    ) toilets
    |> return_json_list 200
  in try
    logic ()
  with _ -> error 400 "invalid request" "generic error, please report this"

let create req =
  let logic (json : M.create) =
    match Session.find "id" req with
    | None -> error 400 "invalid request" "no session id found"
    | Some creator ->
      let%lwt () = DB.exec Q.create (json.name, json.place, json.floor, creator) in
      return 200 [("message", "toilet created")]
  in try
    logic
    (* |> V.validate_schema M.validate_create *)
    |> V.validate_model M.create_of_yojson
    |> V.validate_json req
  with _ -> error 400 "invalid request" "generic error, please report this"
