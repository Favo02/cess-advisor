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
