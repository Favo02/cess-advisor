(* return expiration epoch (current epoch + 1h) *)
let expiration ?(seconds = 3600) () =
  Unix.time () +. float_of_int seconds
  |> int_of_float
  |> Printf.sprintf "%d"

(* send an HTTP response with ~status and ~json payload *)
let return (status : int) (json : (string * string) list) =
  Opium.Response.of_json
    ?status: (Some (Opium.Status.of_code status))
    (`Assoc (json |> List.map (fun (k, v) -> (k, `String v))))
  |> Lwt.return

(* send an HTTP response with ~status and ~json payload *)
let return_json (status : int) (json : Yojson.Safe.t) =
  Opium.Response.of_json
    ?status: (Some (Opium.Status.of_code status))
    json
  |> Lwt.return

(* send an HTTP response with ~status and ~json payload *)
let return_json_list (status : int) (json : Yojson.Safe.t list) =
  Opium.Response.of_json
    ?status: (Some (Opium.Status.of_code status))
    (`List json)
  |> Lwt.return

(* same as return, but also sets ~session *)
let session_return ?(max_age = 86400L) (status : int) (json : (string * string) list) (session : (string * string) list) =
  Opium.Response.of_json
    ?status: (Some (Opium.Status.of_code status))
    (`Assoc (json |> List.map (fun (k, v) -> (k, `String v))))
  |> Session.set_cookie ~max_age:max_age ~scope:"/" ~same_site:"strict" ~http_only:true session
  |> Lwt.return

(* same as return but with fixed json payload fiels "error" and "message" *)
let error status err message = return status [
  ("error", err);
  ("message", message)
]

(* same as error, but also sets ~session *)
let session_error status err message session = session_return status [
  ("error", err);
  ("message", message)
] session

(* return a simple request handler that returns ~status and ~json *)
let simple_handler status json =
  fun _ -> return status json
