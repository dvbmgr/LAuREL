module LAuREL.Lib (stdlib) where

	import Data.Functor
	import Data.String.Utils
	import LAuREL.Types

	o_add :: Lib -> [Expr] -> Evaluated
	o_add lib [Type (Integer a), Type (Integer b)] =
		Evaluated lib $ return $ Type $ Integer $ a + b

	o_sub :: Lib -> [Expr] -> Evaluated
	o_sub lib [Type (Integer a), Type (Integer b)] =
		Evaluated lib $ return $ Type $ Integer $ a - b

	o_mul :: Lib -> [Expr] -> Evaluated
	o_mul lib [Type (Integer a), Type (Integer b)] =
		Evaluated lib $ return $ Type $ Integer $ a * b

	o_forget :: Lib -> [Expr] -> Evaluated
	o_forget lib [a,b] =
		Evaluated lib $ return b

	o_at :: Lib -> [Expr] -> Evaluated 
	o_at lib [Type (List a), Type (Integer s)] = 
		Evaluated lib $ return $ Type (a !! s)

	o_pass :: Lib -> [Expr] -> Evaluated
	o_pass lib [a] = 
		Evaluated lib $ return a

	b_eq :: Lib -> [Expr] -> Evaluated
	b_eq lib [Type (Integer a), Type (Integer b)] =
		Evaluated lib $ return $ Type $ Bool $ a == b
	b_eq lib [Type (String a), Type (String b)] =
		Evaluated lib $ return $ Type $ Bool $ a == b

	f_print :: Lib -> [Expr] -> Evaluated
	f_print lib [Type (None)] =
		Evaluated lib $ print "None" >> return (Type None)
	f_print lib a = 
		Evaluated lib $ print a >> return (Type None)

	f_input :: Lib -> [Expr] -> Evaluated
	f_input lib _ =
		Evaluated lib $ (getLine >>= return . Type . String )

	f_str_to_int :: Lib -> [Expr] -> Evaluated
	f_str_to_int lib [Type (String a)] =
		Evaluated lib $ return $ Type $ Integer $ read a

	f_str_to_float :: Lib -> [Expr] -> Evaluated
	f_str_to_float lib [Type (String a)] =
		Evaluated lib $ return $ Type $ Float $ read a

	f_error :: Lib -> [Expr] -> Evaluated
	f_error lib [Type (String a)] = 
		Evaluated lib $ error a

	f_split :: Lib -> [Expr] -> Evaluated 
	f_split lib [Type (String del), Type (String str)] = 
		Evaluated lib $ return $ Type (List (map (String) sp))
		where 
			sp = split del str

	f_readfile :: Lib -> [Expr] -> Evaluated 
	f_readfile lib [Type (String a)] = 
		Evaluated lib (readFile a >>= return . Type . String)

	-- |The standard library
	stdlib :: Lib
	stdlib = Lib [
				LibFunction "+" ["Integer", "Integer", "Integer"] ["a", "b"] o_add $ Just "Adds a to b",
				LibFunction "-" ["Integer", "Integer", "Integer"] ["a", "b"] o_sub $ Just "Sub b to a",
				LibFunction "*" ["Integer", "Integer", "Integer"] ["a", "b"] o_mul $ Just "Multiplies a by b",
				LibFunction "@" ["[String]", "Integer", "String"] ["a", "b"] o_at $ Just "Gets element b of a",
				LibFunction ";" ["*", "*", "*"] ["a", "b"] o_forget $ Just "Removes the previous functions value",
				LibFunction "==" ["Integer", "Integer", "Bool"] ["a", "b"] b_eq $ Just "Checks the equallity",
				LibFunction "str_to_int" ["String", "Integer"] ["a"] f_str_to_int $ Just "Converts string to integer",
				LibFunction "str_to_float" ["String", "Float"] ["a"] f_str_to_float $ Just "Converts string to float",
				LibFunction "split" ["String", "String", "[String]"] ["a", "b"] f_split $ Just "Splits b at deliminators a",
				LibFunction "print" ["String", "None"] ["a"] f_print $ Just "Prints a",
				LibFunction "input" ["String"] [] f_input $ Just "Asks for input",
				LibFunction "error" ["String", "*"] ["a"] f_error $ Just "Stops the program and shows the message",
				LibFunction "readfile" ["String", "String"] ["a"] f_readfile $ Just "Reads the givent file"
			 ]