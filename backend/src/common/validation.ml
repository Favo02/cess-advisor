open Utils

(* check that ~req has a valid JSON body *)
let validate_json req next =
  match%lwt Opium.Request.to_json req with
  | Some json -> next json
  | _ -> error 400 "invalid request" "invalid body"

(* check that ~json has same structure (fields and types) of ~model *)
let validate_model model next json =
  match
    try Some (model json)
    with _ -> None
  with
  | Some valid -> next valid
  | None -> error 400 "invalid request" "invalid body fields"

(* check that ~json is compatible with ~schema *)
let validate_schema schema next json =
  match schema json with
  | Ok _ -> next json
  (* TODO: return decent error message *)
  | Error _ -> error 400 "invalid request" "invalid schema"
  (* match e with
  | Validate.BaseError e -> error 400 "invalid request" e.code
  | Validate.IterableError _ -> error 400 "invalid request" "iter"
  | Validate.RecordError ((a, _) :: _) -> error 400 "invalid request" a
  | _ -> error 400 "invalid request" "" *)
