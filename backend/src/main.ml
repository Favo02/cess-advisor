open Sihl
open Common.Utils

(* routes accessible to everyone *)
let public_routes = Web.choose
  ~scope: "/"
  ~middlewares: []
  [
    Web.get   "/version"          (simple_handler 200 [("version", "0.0.1")]);
  ]

(* routes accessible only to users not logged in *)
let no_auth_routes = Web.choose
  ~scope: "/"
  ~middlewares: [ Middlewares.require_no_login ]
  [
    Web.post  "/login"            Handlers.Login.login;
    Web.post  "/user/register"    Handlers.Users.create;
  ]

(* routes accessible only to logged users *)
let auth_routes = Web.choose
  ~scope: "/"
  ~middlewares: [ Middlewares.require_login ]
  [
    Web.get   "/user/me"          Handlers.Users.me;
    Web.post  "/logout"           Handlers.Login.logout;
  ]

let router = Web.choose
  ~scope: "/api/"
  ~middlewares: [ Web.Middleware.error () ]
  [
    public_routes;
    no_auth_routes;
    auth_routes;
  ]

let services = [
  Database.register ();
  Web.Http.register router;
]

let () = App.(empty |> with_services services |> run)
