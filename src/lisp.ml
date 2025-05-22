open Sexp

(* Simple value type for the interpreter *)
type value =
  | Int of int
  | Bool of bool
  | List of value list
  | Symbol of string

exception Runtime_error of string

let rec value_to_string = function
  | Int n -> string_of_int n
  | Bool b -> string_of_bool b
  | List xs -> "(" ^ String.concat " " (List.map value_to_string xs) ^ ")"
  | Symbol s -> s

let as_int = function
  | Int n -> n
  | _ -> raise (Runtime_error "expected int")

let as_bool = function
  | Bool b -> b
  | _ -> raise (Runtime_error "expected bool")

let apply_builtin op args =
  match op, args with
  | "+", [Int a; Int b] -> Int (a + b)
  | "-", [Int a; Int b] -> Int (a - b)
  | "*", [Int a; Int b] -> Int (a * b)
  | "/", [Int a; Int b] -> Int (a / b)
  | "not", [Bool b] -> Bool (not b)
  | "and", [Bool a; Bool b] -> Bool (a && b)
  | "or", [Bool a; Bool b] -> Bool (a || b)
  | _ -> raise (Runtime_error ("unknown builtin " ^ op))

let rec eval = function
  | Atom s -> (
      try Int (int_of_string s) with Failure _ -> Symbol s)
  | List (Atom op :: args) ->
      let args = List.map eval args in
      apply_builtin op args
  | List lst -> List (List.map eval lst)

let print v = print_endline (value_to_string v)
