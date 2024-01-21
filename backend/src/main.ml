open Sihl

let routes : Web.router = {
  scope = "/api/";
  routes = [

    (Web.Post, "/login", Auth.post_login);

  ];

  middlewares = [
    Sihl.Web.Middleware.error ()
  ];
}

let services = [
  Sihl.Database.register ();
  Sihl.Web.Http.register routes
]

let () = App.(empty |> with_services services |> run)
