open Common.Utils

let me req =
  let id = Sihl.Web.Session.find "id" req in
  let username = Sihl.Web.Session.find "username" req in
  match id, username with
  | Some user_id, Some username -> return (
    `Assoc [
      ("id", `String user_id);
      ("username", `String username)
    ])
  | _ -> error 401 "unauthorized" "not logged in"
