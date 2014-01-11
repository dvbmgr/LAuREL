limport LAuREL.Types
import LAuREL.Parser
import LAuREL.Eval
import LAuREL.Lib
import System.Environment
import Data.Functor

data Config = Config {
			input :: String
		}

-- |Parsing arguments
parseArgs :: Config -> [String] -> Config
parseArgs c [] = c
parseArgs _ ("-h":xs) = 
	error $ "This is the interpreter for LAuREL.\n"++
				"Usage: laurel [-h] [file|-]\n"++
				"\t\t-h\t shows this help\n"++
				"If file equals to -, stdin will be read as input.\n" 
parseArgs c ["-"] = 
	c { input = "stdin" }
parseArgs c [n] = 
	c { input = n }
parseArgs c _ =
	parseArgs c ["-h"]

main :: IO ()
main = 
	((parseArgs (Config { input = "stdin" })) <$> getArgs) >>= \config ->
		((if input config == "stdin" then getContents else readFile $ input config) >>= \file -> (
			let 
				parser = parseLAuREL file
			in
			evaluateLAuREL stdlib parser >> return ()))
