open Common.Utils

let require_login =
  let require_login next req =
    let user_id = Sihl.Web.Session.find "user_id" req in
    match user_id with
    | Some _ -> next req
    | None -> unauthorized ()
  in
  Rock.Middleware.create ~filter: require_login ~name: "require login"
