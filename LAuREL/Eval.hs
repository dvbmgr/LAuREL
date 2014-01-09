module LAuREL.Eval where

	import LAuREL.Types
	import LAuREL.Lib 
	
	evalulateLAuREL :: Lib -> Expr -> IO Expr
	evalulateLAuREL l e = 
			case eval l e of
				(_, ed) -> ed
		where 
			eval :: Lib -> Expr -> (Lib, IO Expr)
			eval l (Op o exprl exprr) = 
						(   l,
							case eval l exprl of
								(_,ex1') -> ex1' >>= \ex1 ->
									case eval l exprr of
										(_,ex2') -> ex2' >>= \ex2 ->
											(get_fun_in_lib l o) [ex1,ex2]
						)

			eval l (If c e f) = 
						(   l, 
							case eval l c of
								(_,p') -> p' >>= \p ->
									case p of
										Type (Bool True) -> case eval l e of (_,r) -> r
										Type (Bool False) -> case eval l f of (_,r) -> r
										_ -> error "Unvalid parameter for IF"
						)

			eval l@(Lib n) (Fun i d t a e) = 
						if length a == length t - 1 then
							(   add_to_lib l i t a (\r -> 
									case eval (
										Lib (
											map (\p ->
												if 
													typeinfo (case r !! p of Type a -> a) == t !! p 
												then 
													LibFunction (a !! p) [t !! p] [] (\[] -> 
														let 
															f = r !! p
														in 
														if
															typeinfo (case f of Type a -> a) == last t
														then
															return $ f 
														else
															error "Return type is incorrect") Nothing
												else
													error "Types does not match"
											) [0..length a]++n
										)
								) e of (_, e) -> e) d, 
								return $ None
							)
						else
							error "Arguments length does not match to types"

			eval l (Call i e) = 
						(   l,
							get_fun_in_lib l i e
						)

			eval l (Atom "true") = 
						(   l, 
							return $ Type $ Bool True
						)

			eval l (Atom "false") = 
						(   l, 
							return $ Type $ Bool False
						)

			eval l n = 
						(   l,
							return $ n 
						)	

			eval l (Root f) =
						(   l, 
							(eval (
								foldl (
									\m n -> 
										case (eval m n) of 
											(z, _) -> fusion_lib z m
								) l f) $ Call "main" [])
						)

			eval l v = 
						(   l, 
							error "Unexpected "++show v
						)
