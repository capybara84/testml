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

The entire system is implemented in OCaml. The front end will eventually compile
TestML code to S-expressions, which are then evaluated by a minimalist Lisp
interpreter. A small REPL is planned for interactive testing.  At this early
stage only the S-expression interpreter is available.

## Building

The project uses `dune` for building.  To compile the interpreter run:

```bash
dune build
```

You can then execute the interpreter with:

```bash
dune exec testml "( + 1 2 )"
```

Without a command line argument the program starts a very small REPL that reads
a single S-expression from standard input.
