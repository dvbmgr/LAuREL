import LAuREL.Types
import LAuREL.Parser
import LAuREL.Eval
import LAuREL.Lib
import System.Environment
import Data.Functor

data Config = Config {
			input :: String,
			parseOnly :: Bool
		}

errorMsg :: String
errorMsg = 		"Usage: laurel [-h] [-p] [file|-]\n"++
				"\t\t-h\t shows this help\n"++
				"\t\t-p\t only display the AST\n"++
				"If file equals to -, stdin will be read as input.\n" 

-- |Parsing arguments
parseArgs :: Config -> [String] -> Config
parseArgs c [] = c
parseArgs c ("-p":xs) = 
	parseArgs (c { parseOnly = True }) xs
parseArgs _ ("-h":xs) = 
	error $ "This is the interpreter for LAuREL.\n"++ errorMsg
parseArgs c ["-"] = 
	c { input = "stdin" }
parseArgs c [n] = 
	c { input = n }
parseArgs c (t) =
	error $ "Unvalid argument " ++ show t ++ ".\n" ++ errorMsg

main :: IO ()
main = 
	((parseArgs (Config { input = "stdin", parseOnly = False })) <$> getArgs) >>= \config ->
		((if input config == "stdin" then getContents else readFile $ input config) >>= \file -> (
			let 
				parser = parseLAuREL file
			in
			if parseOnly config then
				print parser
			else
				evaluateLAuREL stdlib parser >> return ()))
