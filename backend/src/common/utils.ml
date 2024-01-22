(* send an HTTP response with ~status and ~json payload *)
let return (status : int) (json : (string * string) list) =
  Opium.Response.of_json
    ?status: (Some (Opium.Status.of_code status))
    (`Assoc (json |> List.map (fun (k, v) -> (k, `String v))))
  |> Lwt.return

(* same as return but with fixed json payload fiels "error" and "message" *)
let error status err message = return status [
  ("error", err);
  ("message", message)
]

(* return a simple request handler that returns ~status and ~json *)
let simple_handler status json =
  fun _ -> return status json

(* frequently used responses *)
let unauthorized () = error 401 "unauthorized" "not logged in"
let invalid_request () = error 400 "invalid request" "invalid json body"
