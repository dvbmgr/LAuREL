module LAuREL.Eval where

	import LAuREL.Types
	import LAuREL.Lib


		ata Expr =  
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

    evaluate l (Op o e f) = (l, (op l o) <$> (evaluate l e) (evaluate l f))
    evaluate l (If c e f) = (l, if (case evaluate l c of Bool t -> t) then evaluate l e else evaluate l f)
    evaluatex l@(Lib a b) (Fun i t a e) = (Lib a ((drop (length a) t, evaluate (Lib a (map (\i -> []) [0..length a]) e):b))