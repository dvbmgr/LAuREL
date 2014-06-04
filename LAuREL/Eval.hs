module LAuREL.Eval where

  import LAuREL.Types
  import LAuREL.Lib

  import Data.Functor
  import Data.UUID.V4
  import Control.Monad
  import Control.Applicative ((<$>))

  import System.IO.Unsafe

  -- |Evaluates the AST
  evaluateLAuREL ::
                    Lib
                 -> Expr
                 -> IO Expr
  evaluateLAuREL lib expr =
      jexpr $ eval lib expr
    where
      jexpr = join . fmap eExpr
      eval ::
              Lib
           -> Expr
           -> IO Evaluated
      eval lib expr@(Op{})
        = do let eOp = findFunInLib lib $ opOperator expr
             ex1 <- jexpr $ eval lib $ opLeftExpr expr
             ex2 <- jexpr $ eval lib $ opRightExpr expr
             (libFunFun eOp) lib [ex1,ex2]
      eval lib expr@(If{})
        = do eCond <- (jexpr $ eval lib $ ifCond expr)
             case eCond of
               Type _ ->
                  eval lib $ case typeValue eCond of
                                          Bool True -> ifTrue expr
                                          Bool False -> ifFalse expr
                                          _ -> error "Unvalid condition for IF"
               _ -> error "Unvalid condition for IF"
      eval lib expr@(Let{})
        = do let nvalue = LibFunction { libFunId = letName expr,
                                        libFunArgsType = [],
                                        libFunArgsNames = [],
                                        libFunFun = \l _ -> eval l $ letValue expr,
                                        libFunDoc = Nothing }
             r <- jexpr $ eval (funsionLib (Lib [nvalue]) lib) $ letMain expr
             return $ Evaluated lib $ return r 
      eval lib expr@(Call{})
        = do args <- mapM (eval lib) $ callArgs expr
             let fun = findFunInLib lib $ callId expr
             nargs <- mapM eExpr args
             case checkTypes fun $ map typeValue nargs of
               [] -> (libFunFun $ fun) lib nargs
               diff -> let
                        alist = map (\a -> "__arg_" ++ [a]) $ take (length diff) (['a'..'z']++['A'..'Z'])
                      in
                        return $ Evaluated lib $ return Lambda { lambdaArgs = alist,
                                                                 lambdaMain = Call (callId expr) (nargs ++ map (\ i -> Call i []) alist) }  
      eval lib expr@(Type{})
        = return $ Evaluated lib $ return expr
      eval lib expr@(Atom "true")
        = return $ Evaluated lib $ return $ Type $ Bool True
      eval lib expr@(Atom "false")
        = return $ Evaluated lib $ return $ Type $ Bool False
      eval lib expr@(Fun{})
        = let
            nfun = LibFunction { libFunId = funId expr,
                                 libFunArgsType = funType expr,
                                 libFunArgsNames = funArgs expr,
                                 libFunFun = \l a -> eval (funsionLib (Lib (map (mapHelper l a) [0..length a-1])) l) $ funMain expr,
                                 libFunDoc = funDoc expr }
          in
            return $ Evaluated (funsionLib (Lib [nfun]) lib) $ return $ Type None
          where
            mapHelper l t argn =
              LibFunction { libFunId = funArgs expr !! argn,
                            libFunArgsType = [],
                            libFunArgsNames = [],
                            libFunDoc = Nothing,
                            libFunFun = \_ _ -> eval l $ t !! argn}
      eval lib expr@(Lambda{})
        = do fname <- ((++) "__lambda_" . show) <$> nextRandom
             nfun <- eval lib Fun { funId = fname,
                                    funDoc = Nothing,
                                    funType = map (const "*") $ lambdaArgs expr,
                                    funArgs = lambdaArgs expr,
                                    funMain = lambdaMain expr }
             return $ Evaluated (eLib nfun) $ return $ Call fname []
      eval lib expr@(Comment{})
        = return $ Evaluated lib $ return $ Type None
      eval lib expr@(Root{})
        = do lib' <- foldM (\lib'' fun -> do efun <- eval lib'' fun
                                             return $ funsionLib (eLib $ efun) lib'') lib $ root expr
             eval lib' (Call "main" [])
