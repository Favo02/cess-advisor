let error status message detail =
  let json = `Assoc [
    ("status", `Int status);
    ("message", `String message);
    ("detail", `String detail)
  ] in
  Opium.Response.of_json json |> Lwt.return
