module LAuREL.Lib (stdlib) where

	import Data.Functor
	import LAuREL.Types

	o_add :: [Expr] -> IO Expr
	o_add [Type (Integer a), Type (Integer b)] =
		return $ Type $ Integer $ a + b

	o_sub :: [Expr] -> IO Expr
	o_sub [Type (Integer a), Type (Integer b)] =
		return $ Type $ Integer $ a - b

	o_mul :: [Expr] -> IO Expr
	o_mul [Type (Integer a), Type (Integer b)] =
		return $ Type $ Integer $ a * b

	b_eq :: [Expr] -> IO Expr
	b_eq [Type (Integer a), Type (Integer b)] =
		return $ Type $ Bool $ a == b

	f_print :: [Expr] -> IO Expr
	f_print [Type (String a)] =
		putStrLn a >> return (Type None)
	f_print [Type (Integer a)] =
		print a >> return (Type None)
	f_print [Type (Float a)] =
		print a >> return (Type None)
	f_print [Type (Bool a)] =
		print a >> return (Type None)
	f_print [Type (None)] =
		print "None" >> return (Type None)
	f_print a = 
		print a >> return (Type None)

	f_input :: [Expr] -> IO Expr
	f_input _ =
		getLine >>= return . Type . String 

	stdlib :: Lib
	stdlib = Lib [
				LibFunction "+" ["Integer", "Integer", "Integer"] ["a", "b"] o_add $ Just "Adds a to b",
				LibFunction "-" ["Integer", "Integer", "Integer"] ["a", "b"] o_sub $ Just "Sub b to a",
				LibFunction "*" ["Integer", "Integer", "Integer"] ["a", "b"] o_mul $ Just "Multiplies a by b",
				LibFunction "==" ["Integer", "Integer", "Bool"] ["a", "b"] b_eq $ Just "Checks the equallity",
				LibFunction "print" ["String", "None"] ["a"] f_print $ Just "Prints a",
				LibFunction "input" ["String"] [] f_input $ Just "Asks for input"
			 ]