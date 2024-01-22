open Sihl
open Common.Utils

let unprotected_routes = Web.choose
  ~scope: "/"
  ~middlewares: []
  [
    Web.get   "/version"          (simple_handler 200 [("version", "0.0.1")]);
    Web.post  "/login"            Handlers.Login.login;
    Web.post  "/logout"           Handlers.Login.logout;
    Web.post  "/user/register"    Handlers.Users.create;
  ]

let protected_routes = Web.choose
  ~scope: "/"
  ~middlewares: [ Middlewares.require_login ]
  [
    Web.get   "/user/me"          Handlers.Users.me;
  ]

let router = Web.choose
  ~scope: "/api/"
  ~middlewares: [ Web.Middleware.error () ]
  [
    unprotected_routes;
    protected_routes
  ]

let services = [
  Database.register ();
  Web.Http.register router;
]

let () = App.(empty |> with_services services |> run)
