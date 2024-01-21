let return json =
  Opium.Response.of_json json |> Lwt.return

let message key value = return (
  `Assoc [
    (key, `String value)
  ])

let error status message detail = return (
  `Assoc [
    ("status", `Int status);
    ("message", `String message);
    ("detail", `String detail)
  ])

(* messages used frequently *)
let unauthorized () = error 401 "unauthorized" "not logged in"

let simple_handler key value =
  fun _ -> message key value
