open Common.Utils

let require_login =
  let require_login next req =
    let user_id = Sihl.Web.Session.find "id" req in
    match user_id with
    | Some _ -> next req
    | None -> unauthorized ()
  in
  Rock.Middleware.create ~filter: require_login ~name: "require login"

let require_no_login =
  let require_no_login next req =
    let user_id = Sihl.Web.Session.find "id" req in
    match user_id with
    | None -> next req
    | Some _ -> error 401 "unauthorized" "already logged in"
  in
  Rock.Middleware.create ~filter: require_no_login ~name: "require login"

let verify_expiration =
  let verify_expiration next req =
    let expiration = Sihl.Web.Session.find "expiration" req in
    match expiration with
    | Some exp when float_of_string exp > Unix.time () -> next req
    | _ -> session_error 401 "unauthorized" "session expired" []
  in
  Rock.Middleware.create ~filter: verify_expiration ~name: "check expiration date"
