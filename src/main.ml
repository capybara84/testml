open Sexp_parser
open Lisp

let () =
  let input =
    if Array.length Sys.argv > 1 then
      Sys.argv.(1)
    else (
      print_string "> ";
      read_line ()
    )
  in
  match parse input with
  | Ok sexp ->
      let result = eval sexp in
      print result
  | Error msg ->
      prerr_endline ("Parse error: " ^ msg)
