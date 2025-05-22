type t =
  | Atom of string
  | List of t list

let rec to_string = function
  | Atom s -> s
  | List xs ->
      "(" ^ String.concat " " (List.map to_string xs) ^ ")"
