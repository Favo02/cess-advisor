open Common.Utils

module Query = struct
  open Caqti_request.Infix
  open Caqti_type.Std

  let get_all =
    unit ->* tup2 (tup4 string string string int) string @@
    "SELECT id, name, place, floor, creator FROM toilets"
end

module Models = struct
  type toilet = {
    id      : string; [@uuid]
    name    : string; [@regex ""]
    place   : string; [@regex ""]
    floor   : int;    [@greater_than -3]
    creator : string; [@uuid]
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
