open Sihl

let unprotected_routes = Web.choose
  ~scope: "/"
  ~middlewares: []
  [
    Web.get "/version" (Common.Utils.simple_handler "version" "0.0.1");
    (* Web.get "/login" (Common.Utils.simple_handler "TODO" "TODO"); *)
    (* Web.get "/logout" (Common.Utils.simple_handler "TODO" "TODO"); *)
  ]

let protected_routes = Web.choose
  ~scope: "/auth/"
  ~middlewares: []
  [
    Web.get "/user/me" (Common.Utils.simple_handler "TODO" "TODO");
  ]

let router = Web.choose ~scope: "/api/" [ unprotected_routes; protected_routes ]

let services = [
  Database.register ();
  Web.Http.register router;
]

let () = App.(empty |> with_services services |> run)
