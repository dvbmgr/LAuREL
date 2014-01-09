module LAuREL.Types where

     type Exprs = [Expr]

     type Id = String
     type FTypes = [String]
     type Operator = String
     type Args = [String]
     type Value = String
     type Doc = Maybe String

     data Expr =  
            Op Operator Expr Expr
          | If Expr Expr Expr
          | Fun Id Doc FTypes Args Expr
          | Lambda Args Expr Exprs
          | Call Id Exprs
          | Type VType
          | Atom String
          | Root Exprs
          deriving (Eq, Show)

     data VType =
            String String
          | Bool Bool
          | Integer Int
          | Float Float
          | None
          deriving (Eq, Show)

     class TypeInfo a where
          typeinfo :: a -> String

     instance TypeInfo VType where
          typeinfo (String _) = "String"
          typeinfo (Bool _) = "Bool"
          typeinfo (Integer _) = "Integer"
          typeinfo (Float _) = "Float"
          typeinfo None = "None"

     data LibFunction = LibFunction Id [String] [String] ([Expr] -> IO Expr) Doc
     data Lib = Lib [LibFunction] deriving (Eq, Show)

     instance Eq LibFunction where
          (==) (LibFunction a b c _ d) (LibFunction a' b' c' _ d') = 
               (a == a' && b == b' && c == c' && d == d')

     instance Show LibFunction where
          show (LibFunction a b c _ d) = "LibFunction "++show a++" "++show b++" "++show c++" <fn> "++show d

     fusion_lib :: Lib -> Lib -> Lib
     fusion_lib (Lib []) l2 = l2
     fusion_lib (Lib ((x@(LibFunction i _ _ _ _)):xs)) (Lib l2) = 
          fusion_lib (Lib xs) (Lib (x:[if i /= j || u == x then u else error "Cannot overwrite function declaration"| u@(LibFunction j _ _ _ _) <- l2]))


     add_to_lib :: Lib -> Id -> [String] -> [String] -> ([Expr] -> IO Expr) -> Doc -> Lib
     add_to_lib l a b c d e = fusion_lib l (Lib [LibFunction a b c d e]) 

     find_fun_in_lib :: Lib -> Id -> LibFunction
     find_fun_in_lib (Lib []) i = 
          error $ "Undefined function "++i
     find_fun_in_lib (Lib ((x@(LibFunction i _ _ _ _)):xs)) s
          | i == s = x
          | otherwise = find_fun_in_lib (Lib xs) s

     get_fun_in_lib :: Lib -> Id -> ([Expr] -> IO Expr)
     get_fun_in_lib l i = 
          case find_fun_in_lib l i of
               LibFunction _ _ _ e _ -> e     

     get_args_in_lib :: Lib -> Id -> [String]
     get_args_in_lib l i = 
          case find_fun_in_lib l i of
               LibFunction _ _ a _ _ -> a