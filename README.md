# LAuREL

Like A Real Programming Language. A functional programming language

## Installation

You'll require a Haskell compilator. GHC is the only tested. `cabal` is also needed.

Type the following commands to build LAuREL and LAuRA.

```
cabal configure
cabal build
```

This will create you two executables: laurel and laura, respectivly in ./dist/build/laurel/laurel and ./dist/build/laura/laura.
To install them, type

```
cabal install
```

## Running the interpreter

To interprete a file, just put

```
laurel file
```

And to generate a documentation

```
laura file
```
