open Sexp

exception Parse_error of string

let is_whitespace = function ' ' | '\t' | '\n' | '\r' -> true | _ -> false

let tokenize s =
  let buf = Buffer.create 16 in
  let tokens = ref [] in
  let push tok = tokens := tok :: !tokens in
  let flush_atom () =
    if Buffer.length buf > 0 then (
      push (Buffer.contents buf);
      Buffer.clear buf)
  in
  String.iter
    (fun c ->
      match c with
      | '(' | ')' as ch ->
          flush_atom (); push (String.make 1 ch)
      | c when is_whitespace c -> flush_atom ()
      | c -> Buffer.add_char buf c)
    s;
  flush_atom (); List.rev !tokens

let parse s =
  let tokens = tokenize s in
  let rec parse_list acc = function
    | [] -> raise (Parse_error "unexpected end of input")
    | ")" :: rest -> (List (List.rev acc), rest)
    | "(" :: rest ->
        let inner, rest' = parse_list [] rest in
        parse_list (inner :: acc) rest'
    | tok :: rest -> parse_list (Atom tok :: acc) rest
  in
  let rec parse_top = function
    | [] -> Error "empty input"
    | "(" :: rest ->
        let sexp, rest' = parse_list [] rest in
        if rest' = [] then
          Ok sexp
        else
          Error "unexpected tokens after expression"
    | tok :: _ -> Ok (Atom tok)
  in
  parse_top tokens
