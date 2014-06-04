module LAuREL.Parser (parseLAuREL) where

  import LAuREL.Types
  import System.IO
  import Control.Monad
  import Control.Applicative ((<$>))
  import Text.ParserCombinators.Parsec
  import Text.ParserCombinators.Parsec.Expr
  import Text.ParserCombinators.Parsec.Language
  import qualified Text.ParserCombinators.Parsec.Token as Token

  _prefix_opers = ["not", "¬"]
  _infix_opers = ["+", "-", "*", "/", ":=", ">", "<", "<=", "≤", "⩽", ">=", "≥", "⩾", "eq", "==", "=", "neq", "/=", "≠", "and", "&&", "∧", "⋀", "or", "||", "∨", "⋁", "⊕", "⊗"]
  _rassoc_opers = ["$"]

  languageDef =
    emptyDef { Token.commentStart
                 = "{%",
               Token.commentEnd
                 = "%}",
               Token.commentLine
                 = "%",
               Token.identStart
                 = letter,
               Token.identLetter
                 = alphaNum <|> oneOf (['α'..'ω']++['Α'..'Ω']),
               Token.reservedNames
                 = [ "if", "else", "end", 
                     "let", "in",
                     "true", "false", 
                     "->", "→", "λ", "\\", "=", ":" ],
               Token.reservedOpNames
                 = _infix_opers ++ _prefix_opers ++ _rassoc_opers,
               Token.caseSensitive
                 = True
             }

  lexer
    = Token.makeTokenParser languageDef

  identifier
    = Token.identifier lexer
  reserved
    = Token.reserved lexer
  comma
    = Token.comma lexer
  reservedOp
    = Token.reservedOp lexer
  parens
    = Token.parens lexer
  brackets
    = Token.brackets lexer
  integer
    = Token.integer lexer
  floating
    = Token.float lexer
  stringLiteral 
    = Token.stringLiteral lexer
  whiteSpace
    = Token.whiteSpace lexer
  type_
    = (brackets type_ >>= \a -> return $ "["++a++"]") 
      <|> do c <- upper 
             cs <- many alphaNum
             return (c:cs)
  types
    = sepBy type_ whiteSpace
  types'
    = sepBy1 type_ whiteSpace
  arguments
    = sepBy identifier whiteSpace
  arguments'
    = sepBy1 identifier whiteSpace

  parseLAuREL :: 
                 String
              -> Expr
  parseLAuREL input
    = case parse laurelParser "" input of 
        Right parsed -> Root parsed
        Left err -> error $ show err

  laurelParser :: 
                  Parser Exprs
  laurelParser
    =  whiteSpace 
    >> many1 functionDefinition

  functionDefinition ::
                        Parser Expr 
  functionDefinition
    = do name <- identifier
         reserved ":"
         types <- types'
         string name
         args <- arguments
         reservedOp ":="
         body <- statement
         reserved "."
         return Fun { funId = name,
                      funDoc = Nothing,
                      funType = types,
                      funArgs = args,
                      funMain = body }


  statement :: 
               Parser Expr
  statement 
    =   parens statement
    <|> ifStatement
    <|> lambdaStatement
    <|> letStatement
    <|> callStatement
    <|> exprStatement

  ifStatement :: 
                 Parser Expr
  ifStatement 
    = do reserved "if"
         condition <- exprStatement
         reserved "->" <|> reserved "→"
         ifpos <- statement
         reserved "else"
         ifneg <- statement
         reserved "end"
         return If { ifCond = condition,
                     ifTrue = ifpos,
                     ifFalse = ifneg }

  lambdaStatement ::
                     Parser Expr
  lambdaStatement
    = do reserved "λ" <|> reserved "\\"
         args <- arguments'
         reserved "->" <|> reserved "→"
         body <- statement
         return Lambda { lambdaArgs = args, 
                         lambdaMain = body }

  letStatement ::
                  Parser Expr
  letStatement
    = do reserved "let"
         name <- identifier
         reservedOp ":="
         value <- statement
         reserved "in"
         body <- statement
         return Let { letName = name, 
                      letValue = value,
                      letMain = body }

  callStatement ::
                   Parser Expr
  callStatement
    = do name <- identifier
         args <- many statement
         return Call { callId = name,
                       callArgs = args }

  exprStatement :: 
                 Parser Expr
  exprStatement
    = buildExpressionParser oOperators oTerms
    where
      oTerms
        =   parens statement
        <|> Type <$> dataP
      dataP
        =   (reserved "true" >> return $ Bool $ True)
        <|> (reserved "false" >> return $ Bool $ False)
        <|> (reservedOp "-" >> integer >>= return . Integer . (-) 0)
        <|> (integer >>= return . Integer)
        <|> (reservedOp "-" >> floating >>= return . Float . (-) 0)
        <|> (floating >>= return . Float)
        <|> (brackets (sepBy1 dataP comma) >>= return . List)
        <|> (stringLiteral >>= return . String)
      oOperators
        =  [ [Infix  (reservedOp op >> return (Op op)) AssocLeft  ] | op <- _infix_opers ]
        ++ [ [Infix  (reservedOp op >> return (Op op)) AssocRight ] | op <- _rassoc_opers ]

