(* return expiration epoch (current epoch + 1h) *)
let expiration () =
  Unix.time () +. 3600.
  |> int_of_float
  |> Printf.sprintf "%d"

(* return current date in format "YYYY-MM-DD" *)
let current_date () =
  let time = Unix.time () in
  let tm = Unix.localtime time in
  Printf.sprintf "%04d-%02d-%02d"
    (1900 + tm.Unix.tm_year)
    (1 + tm.Unix.tm_mon)
    tm.Unix.tm_mday

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
let session_return (status : int) (json : (string * string) list) (session : (string * string) list) =
  Opium.Response.of_json
    ?status: (Some (Opium.Status.of_code status))
    (`Assoc (json |> List.map (fun (k, v) -> (k, `String v))))
  |> Sihl.Web.Session.set session
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
