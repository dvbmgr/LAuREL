module LAuREL.Types where

    type Exprs = [Expr]

    type Id = String
    type FTypes = [String]
    type Operator = String
    type Args = [String]
    type Value = String
    type Doc = Maybe String

    data Evaluated = Evaluated { eLib :: Lib,
                                 eExpr :: IO Expr }

    data Expr =  
            Op { opOperator :: Operator,
                 opLeftExpr :: Expr,
                 opRightExpr :: Expr }
          | If { ifCond :: Expr,
                 ifTrue :: Expr,
                 ifFalse :: Expr }
          | Let { letName :: Id,
                  letValue :: Expr,
                  letMain :: Expr }
          | Fun { funId :: Id,
                  funDoc :: Doc,
                  funType :: FTypes,
                  funArgs :: Args,
                  funMain :: Expr }
          | Lambda { lambdaArgs :: Args,
                     lambdaMain :: Expr }
          | Call { callId :: Id,
                   callArgs :: Exprs }
          | Type { typeValue :: VType }
          | Atom { atomValue :: String }
          | Root { root :: Exprs }
          | Comment { commentMark :: Maybe String,
                      commentContent :: String }
          deriving (Eq, Show)

    data VType =
            String String
          | Bool Bool
          | Integer Int
          | Float Double
          | List [VType]
          | Anything
          | None
          deriving (Eq, Show)

    data Manual = 
            Global String
          | Author String
          | Version String
          | License String
          | Date String
          | ProjectName String
          | Method String [String] String
          | Defs [Manual]
          deriving (Show)

    class TypeInfo a where
          typeinfo :: a -> String

    instance TypeInfo VType where
          typeinfo (String _) = "String"
          typeinfo (Bool _) = "Bool"
          typeinfo (Integer _) = "Integer"
          typeinfo (Float _) = "Float"
          typeinfo (List x) = "["++typeinfo (head x) ++ "]"
          typeinfo Anything = "*"
          typeinfo None = "()"

    data LibFunction = LibFunction { libFunId :: Id,
                                      libFunArgsType :: FTypes,
                                      libFunArgsNames :: Args,
                                      libFunFun :: Lib -> [Expr] -> Evaluated,
                                      libFunDoc :: Doc
                                    } 
    data Lib = Lib [LibFunction] deriving (Eq, Show)

    instance Eq LibFunction where
          (==) (LibFunction a b c _ d) (LibFunction a' b' c' _ d') = 
               a == a' && b == b' && c == c' && d == d'

    instance Show LibFunction where
          show (LibFunction a b c _ d) = "LibFunction "++show a++" "++show b++" "++show c++" <fn> "++show d

     -- |Concats a to b, removing conflits
    funsionLib :: Lib -> Lib -> Lib
    funsionLib (Lib []) l2 = l2
    funsionLib (Lib ((x@(LibFunction i _ _ _ _)):xs)) (Lib l2) = 
          funsionLib (Lib xs) (Lib (x:[if i /= j || u == x then u else error "Cannot overwrite function declaration"| u@(LibFunction j _ _ _ _) <- l2])) -- Don't change this, it works…

     -- |Returns a function from the lib
    findFunInLib :: Lib -> Id -> LibFunction
    findFunInLib (Lib []) i = 
          error $ "Undefined function " ++ i
    findFunInLib (Lib (x:xs)) s
          | libFunId x == s = x
          | otherwise = findFunInLib (Lib xs) s

    checkTypes ::
                 LibFunction
              -> [VType]
              -> Args
    checkTypes fun params
      = let 
          args = libFunArgsNames fun
        in 
          compare args params
        where
          compare :: [String] -> [VType] -> [String]
          compare (a:as) (p:ps)
            | a == typeinfo p = compare as ps
            | a /= typeinfo p = error ("Unvalid argument of type " ++ typeinfo p ++ " when calling " ++ libFunId fun)
          compare [] [] 
            = []
          compare a []
            = a
          compare [] _
            = error $ "Too many arguments given to " ++ libFunId fun  
