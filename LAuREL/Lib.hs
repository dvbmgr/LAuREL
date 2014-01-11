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

	o_forget :: [Expr] -> IO Expr
	o_forget [a,b] =
		return $ b

	b_eq :: [Expr] -> IO Expr
	b_eq [Type (Integer a), Type (Integer b)] =
		return $ Type $ Bool $ a == b
	b_eq [Type (String a), Type (String b)] =
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

	f_str_to_int :: [Expr] -> IO Expr
	f_str_to_int [Type (String a)] =
		return $ Type $ Integer $ read a

	f_str_to_float :: [Expr] -> IO Expr
	f_str_to_float [Type (String a)] =
		return $ Type $ Float $ read a

	f_error :: [Expr] -> IO Expr
	f_error [Type (String a)] = 
		error a

	-- |The standard library
	stdlib :: Lib
	stdlib = Lib [
				LibFunction "+" ["Integer", "Integer", "Integer"] ["a", "b"] o_add $ Just "Adds a to b",
				LibFunction "-" ["Integer", "Integer", "Integer"] ["a", "b"] o_sub $ Just "Sub b to a",
				LibFunction "*" ["Integer", "Integer", "Integer"] ["a", "b"] o_mul $ Just "Multiplies a by b",
				LibFunction ">>" ["*", "*", "*"] ["a", "b"] o_forget $ Just "Removes the previous functions value",
				LibFunction "==" ["Integer", "Integer", "Bool"] ["a", "b"] b_eq $ Just "Checks the equallity",
				LibFunction "str_to_int" ["String", "Integer"] ["a"] f_str_to_int $ Just "Converts string to integer",
				LibFunction "str_to_float" ["String", "Float"] ["a"] f_str_to_float $ Just "Converts string to float",
				LibFunction "print" ["String", "None"] ["a"] f_print $ Just "Prints a",
				LibFunction "input" ["String"] [] f_input $ Just "Asks for input",
				LibFunction "error" ["String", "*"] ["a"] f_error $ Just "Stops the program and shows the message"
			 ]