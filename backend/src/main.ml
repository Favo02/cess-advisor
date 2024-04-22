open Sihl
open Common.Utils
open Common.Middlewares

(* routes accessible to everyone *)
let public = Web.choose ~scope: "/api" ~middlewares: [] [
  Web.get   "/version"          (simple_handler 200 [("version", "0.0.2")]);
  Web.get   "/stats"            Handlers.Various.stats;
  Web.get   "/toilets"          Handlers.Toilets.get_all;
  Web.get   "/toilets/:toilet"  Handlers.Toilets.get;
  Web.get   "/reviews"          Handlers.Reviews.get_all;
  Web.get   "/reviews/:toilet"  Handlers.Reviews.get_by_toilet;
]

(* routes accessible only to users not logged in *)
let no_auth = Web.choose ~scope: "/api" ~middlewares: [ require_no_login; ] [
  Web.post  "/login"            Handlers.Login.login;
  Web.post  "/users/create"     Handlers.Users.create;
]

(* routes accessible only to logged users *)
let auth = Web.choose ~scope: "/api" ~middlewares: [ require_login; verify_expiration; ] [
  Web.get   "/login/verify"     Handlers.Login.verify;
  Web.get   "/users/me"         Handlers.Users.me;
  Web.post  "/logout"           Handlers.Login.logout;
  Web.post  "/toilets/create"   Handlers.Toilets.create;
  Web.post  "/reviews/create"   Handlers.Reviews.create;
]

let router = Web.choose ~middlewares: [ logger; ] [
  public;
  no_auth;
  auth;
  Web.any "**" (simple_handler 404 [("error 404", "Not found")]);
]

let services = [
  Database.register ();
  Web.Http.register router;
]

let () =
  (* Logs.set_level (Some Logs.Debug); *) (* log also request and response body *)
  App.empty |> App.with_services services |> App.run
