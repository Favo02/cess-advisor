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

(* check if a string matches multiple regexes, returning a boolean *)
let multi_regex_check (regexes : string list) (str : string) =
  let compile regex = Re.execp (Re.Perl.re regex |> Re.compile) str in
  List.fold_left (fun acc regex -> acc && (compile regex)) true regexes

(* simulate password regex (lookahead is not supported by ocaml)
  the password will be validated also in the database
  ^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,20}$ *)
let custom_password psw =
  match multi_regex_check ["[A-Za-z]"; "[0-9]"; "[@$!%*#?&]"; "^.{8,20}$"] psw with
  | true -> Ok ()
  | false -> Error (Validate.BaseError { code = "invalid password"; params = [] })
