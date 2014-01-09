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


	f_print :: [Expr] -> IO Expr
	f_print [Type (String a)] =
		print a >> return None

	stdlib :: Lib
	stdlib = Lib [
				LibFunction "+" ["Integer", "Integer", "Integer"] ["a", "b"] o_add $ Just "Adds a to b",
				LibFunction "-" ["Integer", "Integer", "Integer"] ["a", "b"] o_sub $ Just "Sub b to a",
				LibFunction "*" ["Integer", "Integer", "Integer"] ["a", "b"] o_mul $ Just "Multiplies a by b",
				LibFunction "print" ["String", "None"] ["a"] f_print $ Just "Prints a"
			 ]