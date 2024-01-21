let message key value =
  let json = `Assoc [
    (key, `String value)
  ] in
  Opium.Response.of_json json |> Lwt.return

let error status message detail =
  let json = `Assoc [
    ("status", `Int status);
    ("message", `String message);
    ("detail", `String detail)
  ] in
  Opium.Response.of_json json |> Lwt.return

let simple_handler key value =
  fun _ -> message key value
