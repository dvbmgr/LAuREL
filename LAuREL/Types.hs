module LAuREL.Types where

     type Exprs = [Expr]

     newtype Id = Id String

     data Expr =  
            EqOp EqOp Expr Expr
          | Op Operator Expr Expr
          | If Expr Expr Expr
          | Fun Id Expr
          | Type Id
          | Num Int
          | Str String
          | Float Float
          | Bool Bool
          | None
          deriving (Eq)

     data Operator = Operator String
          deriving (Eq, Show)