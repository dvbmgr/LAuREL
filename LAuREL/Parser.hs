module LAuREL.Parser (parseLAuREL) where

	import LAuREL.Types
	import Text.ParserCombinators.Parsec
	import Control.Applicative hiding (many, (<|>))
	import Data.Functor

	binoperator = many1 $ char "+*/!?^"
	assign = string ":="
	eqoperator = oneOf "></=" <* char '='
	ne = ";" <|> newline 

	parseLAuREL :: String -> Exprs
	parseLAuREL input = case parse parseAll "parse error" input of
		Right parsed -> parsed
		Left err -> error $ show err

	parseAll :: Parser Exprs
	parseAll = many parseExpr

	parseExpr :: Parser Expr
	parseExpr = 
		try parseParenthesis <|>

	parseIf :: Parser Expr
	parseIf = 
		between "if"
