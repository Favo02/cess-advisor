open Sihl
open Common.Utils
open Common.Middlewares

(* routes accessible to everyone *)
let public_routes = Web.choose
  ~scope: "/"
  ~middlewares: []
  [
    Web.get   "/version"          (simple_handler 200 [("version", "0.0.2")]);
    Web.get   "/toilets"          Handlers.Toilets.get_all;
    Web.get   "/reviews"          Handlers.Reviews.get_all;
  ]

(* routes accessible only to users not logged in *)
let no_auth_routes = Web.choose
  ~scope: "/"
  ~middlewares: [ require_no_login ]
  [
    Web.post  "/login"            Handlers.Login.login;
    Web.post  "/users/create"     Handlers.Users.create;
  ]

(* routes accessible only to logged users *)
let auth_routes = Web.choose
  ~scope: "/"
  ~middlewares: [ require_login; verify_expiration ]
  [
    Web.get   "/login/verify"     Handlers.Login.verify;
    Web.get   "/users/me"         Handlers.Users.me;
    Web.post  "/logout"           Handlers.Login.logout;
    Web.post  "/toilets/create"   Handlers.Toilets.create;
    Web.post  "/reviews/create"   Handlers.Reviews.create;
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
