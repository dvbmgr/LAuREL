module LAuREL.Types where

     type Exprs = [Expr]

     type Id = String
     type FTypes = [String]
     type Operator = String
     type Args = [String]

     data Expr =  
            Op Operator Expr Expr
          | If Expr Expr Expr
          | Fun Id FTypes Args Expr
          | Lambda Args Expr Exprs
          | Call Id Exprs
          | Type Id
          | Integer Int
          | String String
          | Float Float
          | Bool Bool
          | None
          deriving (Eq, Show)
