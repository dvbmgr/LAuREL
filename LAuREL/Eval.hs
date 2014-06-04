module LAuREL.Eval where

  import LAuREL.Types
  import LAuREL.Lib

  import Data.Functor
  import Data.UUID.V4
  import Control.Monad
  import Control.Applicative ((<$>))

  -- |Evaluates the AST
  evaluateLAuREL ::
                    Lib
                 -> Expr
                 -> IO Expr
  evaluateLAuREL lib expr =
      eExpr $ eval lib expr
    where
      eval ::
              Lib
           -> Expr
           -> Evaluated
      eval lib expr@(Op{})
        = let
            eOp = findFunInLib lib $ opOperator expr
            ex1 = eExpr $ eval lib $ opLeftExpr expr
            ex2 = eExpr $ eval lib $ opRightExpr expr
          in
            ex1 >>= \v1 ->
              ex2 >>= \v2 ->
                (libFunFun eOp) lib [v1,v2]
      eval lib expr@(If{})
        = eExpr $ eval lib $ ifCond expr >>= \eCond ->
          case eCond of
            Type _ ->
              eval lib $ case typeValue eCond of
                          Bool True -> ifTrue
                          Bool False -> ifFalse
                          _ -> error "Unvalid condition for IF"
            _ -> error "Unvalid condition for IF"
      eval lib expr@(Let{})
        = let
            nvalue = LibFunction { libFunId = letName expr,
                                   libFunArgsType = [],
                                   libFunArgsNames = [],
                                   libFunFun = letValue expr,
                                   libFunDoc = Nothing }
          in 
            Evaluated lib $ eExpr $ eval (funsionLib (Lib nvalue) lib) $ letMain expr
      eval lib expr@(Call{})
        = mapM (eval lib) $ callArgs expr >>= \args ->
          let
            fun = findFunInLib lib $ callId expr
          in
            case checkTypes fun args of
              [] -> (libFunFun $ fun) lib args
              diff -> let
                        alist = map ("__arg_" ++) $ take (length diff) (['a'..'z']++['A'..'Z'])
                      in
                        Evaluated lib $ return Lambda { lambdaArgs = alist,
                                                        lambdaMain = Call (callId expr) (args ++ map (\ i -> Call i []) alist) }  
      eval lib expr@(Type{})
        = Evaluated lib $ return expr
      eval lib expr@(Atom "true")
        = Evaluated lib $ return $ Type $ Bool True
      eval lib expr@(Atom "false")
        = Evaluated lib $ return $ Type $ Bool False
      eval lib expr@(Fun{})
        = let
            nfun = LibFunction { libFunId = funId expr,
                                 libFunArgsType = funType expr,
                                 libFunArgsNames = funArgs expr,
                                 libFunFun = eval lib $ funMain expr,
                                 libFunDoc = funDoc expr }
          in
            Evaluated (funsionLib (Lib nfun) lib) $ return $ Type None
      eval lib expr@(Lambda{})
        = ((++) "__lambda_" . show) <$> nextRandom >>= \fname ->
          let
            nfun = eval lib Fun { funId = fname,
                                   funDoc = Nothing,
                                   funType = map (const "*") $ lambdaArgs expr,
                                   funArgs = lambdaArgs expr,
                                   funMain = lambdaMain expr }
          in
            Evaluated (eLib nfun) $ return $ Call fname []
      eval lib expr@(Comment{})
        = Evaluated lib $ return $ Type None
      eval lib expr@(Root{})
        = let
            lib' = foldl (\lib'' fun -> funsionLib (eLib $ eval lib'' fun) lib'') lib $ root expr
          in
            eval lib' (Call "main" [])
