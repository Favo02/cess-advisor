open Common.Utils

module Query = struct
  open Caqti_request.Infix
  open Caqti_type.Std

  let stats =
    unit ->! tup3 int int int @@
      "SELECT
        (SELECT COUNT(*) FROM users) AS users,
        (SELECT COUNT(*) FROM toilets) AS toilets,
        (SELECT COUNT(*) FROM reviews) AS reviews"
end

module Models = struct
  type stats = {
    users     : int;
    toilets   : int;
    reviews   : int;
  } [@@deriving yojson] (* no need to validate, read from db *)
end

(* shorthands *)
module Session = Sihl.Web.Session
module DB = Sihl.Database
module V = Common.Validation
module Q = Query
module M = Models

let stats _ =
  let logic () =
    let%lwt users, toilets, reviews = DB.find Q.stats () in
    M.yojson_of_stats M.({ users; toilets; reviews; })
    |> return_json 200
  in try%lwt
    logic ()
  with _ -> error 400 "invalid request" "generic error, please report this"
