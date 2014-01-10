module LAuREL.Eval where

	import LAuREL.Types
	import LAuREL.Lib 

	import Data.Functor
	import Data.UUID.V4
	import Control.Monad
	

	evaluateLAuREL :: Lib -> Expr -> IO Expr
	evaluateLAuREL l e = 
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
										Type (Bool True) -> 
											case eval l e of 
												(_,r) -> 
													r
										Type (Bool False) -> 
											case eval l f of 
												(_,r) -> 
													r
										_ -> error "Unvalid parameter for IF"
						)

			eval l@(Lib n) (Fun i d t a e) = 
						if length a == length t - 1 then
							(   add_to_lib l i t a (\r -> 
									case eval (
										Lib (
											map (\p -> 
													LibFunction (a !! p) [t !! p] [] (\[] -> 
														(	case (eval l $ r !! p) of (_,rp') -> rp') >>= \rp -> 
															(if
																(typeinfo (case rp of Type a -> a) == t !! p) || (t !! p == "*")
															then
																return rp
															else
																error "Type is incorrect")) Nothing
												) [0..length a-1]++n
										)
								) e of (_, e') -> 
									e' >>= \e -> 
										if 
											(typeinfo (case e of Type a -> a) == last t) || ("*" == last t)
										then 
											return $ e 
										else 
											error $ "Return type is incorrect") d, 
								return $ Type None
							)
						else
							error "Arguments length does not match to types"

			eval l (Lambda a e f) = 
						(	l,
							do
								name <- show <$> nextRandom
								case eval l (Fun name Nothing ["*"|_ <- [0..length a]] a e) of
									(l', _) -> 
										case eval l' (Call name f) of 
											(_, z) -> z
						)

			eval l (Call i e) = 
						(   l,
							(sequence $ map (cw l) e) >>= get_fun_in_lib l i
						)
						where 
							cw :: Lib -> Expr -> IO Expr
							cw l a = 
								case a of 
									Type u -> return a
									otherwise -> 
										case eval l a of
											(l', a') -> 
												a' >>= cw l'

			eval l u@(Type a) = 
						(	l,
							return $ u
						)

			eval l (Atom "true") = 
						(   l, 
							return $ Type $ Bool True
						)

			eval l (Atom "false") = 
						(   l, 
							return $ Type $ Bool False
						)

			eval l (Root f) =
						(   l, 
							case (eval (
								foldl (
									\m n -> 
										case (eval m n) of 
											(z, _) -> fusion_lib z m
								) l f) $ Call "main" []) of
								(_,t) -> t
						)

			eval l (Comment _ c) =
						(	l,
							return $ Type None
						)

			eval l v = 
						(   l, 
							error $ "Unexpected "++show v
						)