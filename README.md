# TestML

This project aims to build a small interpreter for a toy ML-like language. The language is compiled to a Lisp-style S-expression intermediate form, which is then executed by a simple Lisp interpreter.

## Core features

- **Types**: integers, booleans, strings, and lists
- **Expressions**:
  - arithmetic (`+`, `-`, `*`, `/`)
  - boolean operations (`&&`, `||`, `not`)
  - variables and `let` bindings
  - anonymous functions via `fun` and function application
  - conditional expressions using `if ... then ... else`
  - pattern matching
  - recursive function definitions
- Hindley–Milner type inference with `let` polymorphism
- Call-by-value evaluation strategy

The entire system is implemented in OCaml. The front end compiles TestML code to S-expressions and the back end runs those expressions using a minimalist Lisp interpreter. A small REPL is planned for interactive testing.
