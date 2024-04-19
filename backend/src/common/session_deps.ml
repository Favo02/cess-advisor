(*
Dependecies for session.ml, read more in session.ml first comment
Cannot use directly Opium/Sihl dependencies because are not exposed by .mli files
*)

(* Opium dependencies *)

module Opium_Date = struct
  let month_of_int = function
    | 1 -> "Jan"
    | 2 -> "Feb"
    | 3 -> "Mar"
    | 4 -> "Apr"
    | 5 -> "May"
    | 6 -> "Jun"
    | 7 -> "Jul"
    | 8 -> "Aug"
    | 9 -> "Sep"
    | 10 -> "Oct"
    | 11 -> "Nov"
    | 12 -> "Dec"
    | _ -> "Jan"

  type weekday =
    [ `Fri
    | `Mon
    | `Sat
    | `Sun
    | `Thu
    | `Tue
    | `Wed
    ]

  let string_of_weekday : weekday -> string = function
    | `Mon -> "Mon"
    | `Tue -> "Tue"
    | `Wed -> "Wed"
    | `Thu -> "Thu"
    | `Fri -> "Fri"
    | `Sat -> "Sat"
    | `Sun -> "Sun"

  let zero_pad ~len str =
    let pad = len - String.length str in
    if pad > 0
    then List.init (pad + 1) (fun i -> if i = pad then str else "0") |> String.concat ""
    else str

  (* Fri, 07 Aug 2007 08:04:19 GMT *)
  let serialize date_time =
    let ptime = Ptime.of_date_time date_time |> Option.get in
    let weekday = Ptime.weekday ptime |> string_of_weekday in
    let (year, month, day), ((hour, minute, second), _) = date_time in
    Printf.sprintf
      "%s, %s %s %s %s:%s:%s UTC"
      weekday
      (day |> string_of_int |> zero_pad ~len:2)
      (month_of_int month)
      (year |> string_of_int)
      (hour |> string_of_int |> zero_pad ~len:2)
      (minute |> string_of_int |> zero_pad ~len:2)
      (second |> string_of_int |> zero_pad ~len:2)
end

module Opium_List = struct
  include ListLabels

  let replace_or_add ~f to_add l =
    let rec aux acc l found =
      match l with
      | [] -> rev (if not found then to_add :: acc else acc)
      | el :: rest ->
        if f el to_add then aux (to_add :: acc) rest true else aux (el :: acc) rest found
    in
    aux [] l false
end

module Opium_String = struct
  include StringLabels

  let rec check_prefix s ~prefix len i =
    i = len || (s.[i] = prefix.[i] && check_prefix s ~prefix len (i + 1))
  ;;

  let is_prefix s ~prefix =
    let len = length s in
    let prefix_len = length prefix in
    len >= prefix_len && check_prefix s ~prefix prefix_len 0
  ;;
end

(* Sihl private dependencies *)

module Sihl_StrMap = Map.Make (String)

let sihl_to_yojson session =
  `Assoc (
    session
      |> Sihl_StrMap.to_seq
      |> List.of_seq
      |> List.map (fun (k, v) -> k, `String v))

let sihl_to_json session = session |> sihl_to_yojson |> Yojson.Safe.to_string
