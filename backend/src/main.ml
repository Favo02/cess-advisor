open Sihl

let hello_handler (_ : Rock.Request.t) : Rock.Response.t Lwt.t =
  let json =
    `Assoc [("message", `String "Hello, World!")]
  in
  Opium.Response.of_json json
  |> Lwt.return

let routes : Web.router = {
  scope = "/api/";
  routes = [

    (Web.Get, "/", hello_handler);

  ];

  middlewares = [];
}

let services = [
  (* Sihl.Database.register (); *)
  Sihl.Web.Http.register routes
]

let () = App.(empty |> with_services services |> run)
