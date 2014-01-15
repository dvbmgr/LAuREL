module LAuREL.Parser (parseLAuREL) where

	import LAuREL.Types
	import Text.ParserCombinators.Parsec
	import Control.Applicative hiding (many, optional, (<|>))
	import Data.Functor


	-- |Parsing interface
	parseLAuREL :: String -> Expr
	parseLAuREL input = case parse parseAll "parse error" input of
		Right parsed -> Root parsed
		Left err -> error $ show err

	-- |Parses comments and functions
	parseAll :: Parser Exprs
	parseAll = spaces *> many1 ((try parseComment <|> parseFunction) <* optional newline) <* spaces

	-- |Parses comments
	parseComment :: Parser Expr 
	parseComment = do 
		char '%'
		spaces
		d <- optionMaybe (try $ choice [string "author", string "date", string "license", string "version", string "name"] <* char ':' <* spaces)
		spaces
		c <- manyTill anyChar (try newline)
		return $ Comment d c

	-- |Parses functions
	parseFunction :: Parser Expr 
	parseFunction = do
		name <- (do
			a <- lower 
			b <- many (alphaNum <|> char '\'') 
			return $ a:b)
		spaces
		char ':'
		spaces
		types <- sepBy1 (do 
				spaces
				t <- optional $ char '['
				a <- upper
				b <- many1 alphaNum 
				optional $ char ']'
				spaces
				return $ a:b
			) (string "->" <|> string "→")
		spaces
		doc <- optionMaybe (do
			string "%"
			spaces
			c <- manyTill anyChar (try newline)
			return $ c)

		optional newline
		string name
		args <- many (try $ do
			spaces
			a <- lower
			b <- many (alphaNum <|> char '\'' <|> char '_')
			return $ a:b)
		spaces
		char '='
		spaces
		d <- parseExpr
		spaces
		char '.'
		spaces
		return $ Fun name doc types args d 

	-- |Parses all inline expressions
	parseExpr :: Parser Expr 
	parseExpr = spaces *> (try parseLambda <|> try parseIf <|> try parseParenthsis <|> try parseFloat <|> try parseNumber <|> try parseString <|> try parseAtom <|> try parseFunctionCall <|> try parseOp) <* spaces

	-- |Parses the operators
	parseOp :: Parser Expr 
	parseOp = do
		char '<'
		spaces
		a <- parseExpr
		spaces
		o <- many1 $ oneOf "></=+-!$&|*@"
		spaces
		b <- parseExpr
		char '>'
		return $ Op o a b

	-- |Parsing the if structures
	parseIf :: Parser Expr
	parseIf = do
		string "if"
		spaces
		c <- parseExpr
		spaces
		string "->" <|> string "→"
		spaces
		a <- parseExpr
		spaces
		string "else"
		spaces
		b <- parseExpr
		spaces
		string "end"
		return $ If c a b

	-- |Parsing the parenthesis
	parseParenthsis :: Parser Expr
	parseParenthsis = do
		between (char '(' <* optional spaces) (optional spaces *> char ')') parseExpr

	-- |Parsing floating numbers
	parseFloat :: Parser Expr 
	parseFloat = do
		d <- (do
			s <- optionMaybe $ char '-'
			a <- many digit
			b <- char '.'
			c <- many1 digit
			return $ (case s of { Just _ -> '-'; Nothing -> '0' }):(if length a == 0 then "0" else a)++b:c)
		return (Type (Float $ read d))

	-- |Parsing numbers
	parseNumber :: Parser Expr
	parseNumber = do
		s <- optionMaybe $ char '-'
		d <- many1 digit 
		return $ (Type (Integer $ read ((case s of { Just _ -> '-'; Nothing -> '0' }):d)))

	-- |Parsing strings
	parseString :: Parser Expr
	parseString = do 
		char '"'
		c <- many $ noneOf "\""
		char '"'
		return $ Type (String c)

	-- |Parsing atoms
	parseAtom :: Parser Expr 
	parseAtom = do
		char ':'
		n <- many lower
		return $ Atom n

	-- |Parsing functions call
	parseFunctionCall :: Parser Expr
	parseFunctionCall = do
		name <- (do
			a <- lower
			b <- many (alphaNum <|> char '\'' <|> char '_')
			return $ a:b)
		spaces
		args <- sepBy parseExpr (char ',')
		return $ Call name args

	-- |Parsing lambda-expressions
	parseLambda :: Parser Expr
	parseLambda = do
		char '('
		spaces
		char '\\' <|> char 'λ'
		spaces
		args <- many (try $ do
			spaces
			a <- lower  <?> "Functions names must begin with a lower case"
			b <- many (alphaNum <|> char '\'') <?> "Functions names must only contain chars, digits or \"'\""
			return $ a:b)
		spaces
		string "->" <|> string "→"
		spaces
		e <- parseExpr
		spaces
		char ')'
		spaces
		callargs <- sepBy parseExpr (char ',')
		return $ Lambda args e callargs


