module LAuREL.Lib (stdlib) where

	import Data.Functor
	import Data.String.Utils
	import LAuREL.Types

	o_add :: Lib -> [Expr] -> IO Evaluated
	o_add lib [Type (Integer a), Type (Integer b)] =
		return $ Evaluated lib $ return $ Type $ Integer $ a + b

	o_sub :: Lib -> [Expr] -> IO Evaluated
	o_sub lib [Type (Integer a), Type (Integer b)] =
		return $ Evaluated lib $ return $ Type $ Integer $ a - b

	o_mul :: Lib -> [Expr] -> IO Evaluated
	o_mul lib [Type (Integer a), Type (Integer b)] =
		return $ Evaluated lib $ return $ Type $ Integer $ a * b

	o_forget :: Lib -> [Expr] -> IO Evaluated
	o_forget lib [a,b] =
		return $ Evaluated lib $ return b

	o_at :: Lib -> [Expr] -> IO Evaluated 
	o_at lib [Type (List a), Type (Integer s)] = 
		return $ Evaluated lib $ return $ Type (a !! s)

	o_pass :: Lib -> [Expr] -> IO Evaluated
	o_pass lib [a] = 
		return $ Evaluated lib $ return a

	b_eq :: Lib -> [Expr] -> IO Evaluated
	b_eq lib [Type (Integer a), Type (Integer b)] =
		return $ Evaluated lib $ return $ Type $ Bool $ a == b
	b_eq lib [Type (String a), Type (String b)] =
		return $ Evaluated lib $ return $ Type $ Bool $ a == b

	f_print :: Lib -> [Expr] -> IO Evaluated
	f_print lib [Type _tg] 
		= do { putStrLn $ show _tg;
			 return $ Evaluated lib $ return $ Type $ None }

	f_input :: Lib -> [Expr] -> IO Evaluated
	f_input lib _ =
		return $ Evaluated lib $ (getLine >>= return . Type . String )

	f_str_to_int :: Lib -> [Expr] -> IO Evaluated
	f_str_to_int lib [Type (String a)] =
		return $ Evaluated lib $ return $ Type $ Integer $ read a

	f_str_to_float :: Lib -> [Expr] -> IO Evaluated
	f_str_to_float lib [Type (String a)] =
		return $ Evaluated lib $ return $ Type $ Float $ read a

	f_error :: Lib -> [Expr] -> IO Evaluated
	f_error lib [Type (String a)] = 
		return $ Evaluated lib $ error a

	f_split :: Lib -> [Expr] -> IO Evaluated 
	f_split lib [Type (String del), Type (String str)] = 
		return $ Evaluated lib $ return $ Type (List (map (String) sp))
		where 
			sp = split del str

	f_readfile :: Lib -> [Expr] -> IO Evaluated 
	f_readfile lib [Type (String a)] = 
		return $ Evaluated lib (readFile a >>= return . Type . String)

	-- |The standard library
	stdlib :: Lib
	stdlib = Lib [
				LibFunction "+" ["Integer", "Integer", "Integer"] ["a", "b"] o_add $ Just "Adds a to b",
				LibFunction "-" ["Integer", "Integer", "Integer"] ["a", "b"] o_sub $ Just "Sub b to a",
				LibFunction "*" ["Integer", "Integer", "Integer"] ["a", "b"] o_mul $ Just "Multiplies a by b",
				LibFunction "@" ["[String]", "Integer", "String"] ["a", "b"] o_at $ Just "Gets element b of a",
				LibFunction ";" ["*", "*", "*"] ["a", "b"] o_forget $ Just "Removes the previous functions value",
				LibFunction "==" ["Integer", "Integer", "Bool"] ["a", "b"] b_eq $ Just "Checks the equallity",
				LibFunction "$" ["*", "*", "*"] ["a", "b"] o_pass $ Nothing,
				LibFunction "str_to_int" ["String", "Integer"] ["a"] f_str_to_int $ Just "Converts string to integer",
				LibFunction "str_to_float" ["String", "Float"] ["a"] f_str_to_float $ Just "Converts string to float",
				LibFunction "split" ["*", "*", "*"] ["a", "b"] f_split $ Just "Splits b at deliminators a",
				LibFunction "print" ["String", "None"] ["a"] f_print $ Just "Prints a",
				LibFunction "input" ["String"] [] f_input $ Just "Asks for input",
				LibFunction "error" ["String", "*"] ["a"] f_error $ Just "Stops the program and shows the message",
				LibFunction "readfile" ["String", "String"] ["a"] f_readfile $ Just "Reads the givent file"
			 ]