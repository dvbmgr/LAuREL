module LAuREL.Parser (parseLAuREL) where

	import LAuREL.Types
	import Text.ParserCombinators.Parsec
	import Control.Applicative hiding (many, optional, (<|>))
	import Data.Functor


	parseLAuREL :: String -> Exprs
	parseLAuREL input = case parse parseAll "parse error" input of
		Right parsed -> parsed
		Left err -> error $ show err

	parseAll :: Parser Exprs
	parseAll = spaces *> many1 (parseFunction <* optional newline) <* spaces

	parseFunction :: Parser Expr 
	parseFunction = do
		name <- (do
			a <- lower <?> "Functions names must begin with a lower case"
			b <- many (alphaNum <|> char '\'') <?> "Functions names must only contain chars, digits or \"'\""
			return $ a:b)
		spaces
		char ':' <?> "Functions must have a type definition"
		spaces
		types <- sepBy1 (do 
				spaces
				a <- upper <?> "Types have to begin with a upper case"
				b <- many1 alphaNum <?> "Types could only contain chars"
				spaces
				return $ a:b
			) (string "->" <|> string "→")
		spaces
		optional newline <?> "There's a return after a type definition"
		string name <?> "Functions names have to match with type"
		args <- many (try $ do
			spaces
			a <- lower  <?> "Functions names must begin with a lower case"
			b <- many (alphaNum <|> char '\'') <?> "Functions names must only contain chars, digits or \"'\""
			return $ a:b)
		spaces
		char '='
		spaces
		d <- parseExpr
		spaces
		char '.'
		spaces
		return $ Fun name types args d

	parseExpr :: Parser Expr 
	parseExpr = spaces *> (try parseLambda <|> try parseIf <|> try parseParenthsis <|> try parseFloat <|> try parseNumber <|> try parseString <|> try parseFunctionCall <|> try parseOp) <* spaces

	parseOp :: Parser Expr 
	parseOp = do
		char '<'
		spaces
		a <- parseExpr
		spaces
		o <- many1 $ oneOf "></=+-!$&|*"
		spaces
		b <- parseExpr
		char '>'
		return $ Op o a b

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

	parseParenthsis :: Parser Expr
	parseParenthsis = do
		between (char '(' <* optional spaces) (optional spaces *> char ')') parseExpr

	parseFloat :: Parser Expr 
	parseFloat = do
		d <- (do
			s <- optionMaybe $ char '-'
			a <- many digit
			b <- char '.'
			c <- many1 digit
			return $ (case s of { Just _ -> '-'; Nothing -> ' ' }):(if length a == 0 then "0" else a)++b:c)
		return (Float $ read d)

	parseNumber :: Parser Expr
	parseNumber = do
		s <- optionMaybe $ char '-'
		d <- many1 digit 
		return $ (Integer $ read $ (case s of { Just _ -> '-'; Nothing -> ' ' }):d)

	parseString :: Parser Expr
	parseString = do 
		char '"'
		c <- many $ noneOf "\""
		char '"'
		return $ String c

	parseFunctionCall :: Parser Expr
	parseFunctionCall = do
		name <- (do
			a <- lower
			b <- many (alphaNum <|> char '\'')
			return $ a:b)
		spaces
		args <- sepBy parseExpr (char ',')
		return $ Call name args

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


