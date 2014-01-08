module LAuREL.Lib (stdlib) where

	import LAuREL.Types

	o_add :: Num a => a -> a -> a
	o_add = (+)

	o_sub :: Num a => a -> a -> a 
	o_sub = (-)

	o_mul :: Num a => a -> a -> a
	o_mul = (*)

	f_print :: Show a => a -> IO ()
	f_print = print

	f_printf :: Show a => a -> a -> IO ()
	f_printf a b = print a 

	stdlib = ([
				([("Integer", "Integer", "Integer")], o_add, "Adds a to b"),
				([("Integer", "Integer", "Integer")], o_sub, "Substracts b to a"),
				([("Integer", "Integer", "Integer")], o_mul, "Multiplies a by b")
				],[
				([["String", "None"]], f_print, "Shows a")
				])
