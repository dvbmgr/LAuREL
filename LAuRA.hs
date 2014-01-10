import LAuREL.Types
import LAuREL.Parser
import LAuREL.Doc
import System.Environment
import Data.Functor

data Config = Config {
			output :: String,
			otype :: String,
			input :: String
		}

parseArgs :: Config -> [String] -> Config
parseArgs c [] = c
parseArgs c ("-o":o:xs) = 
	parseArgs (c { output = o }) xs
parseArgs c ("-md":xs) = 
	parseArgs (c { otype = "md" }) xs
parseArgs _ ("-h":xs) = 
	error $ "This is the doc generator for LAuREL.\n"++
				"Usage: laura [-h] [-md] [-o output] [file|-]\n"++
				"\t\t-h\t shows this help\n"++
				"\t\t-o\t sets the ouput file (default is stdout)\n"++
				"\t\t-md\t\t outputs markdown (default)\n"++
				"If file equals to -, stdin will be read as input.\n" 
parseArgs c ["-"] = 
	c { input = "stdin" }
parseArgs c [n] = 
	c { input = n }
parseArgs c _ =
	parseArgs c ["-h"]

main :: IO ()
main = 
	((parseArgs (Config { output = "stdout", otype = "md", input = "stdin" })) <$> getArgs) >>= \config ->
		((if input config == "stdin" then getContents else readFile $ input config) >>= \file -> (
			let 
				parser = parseLAuREL file
				rendered = case otype config of
					"md" -> markdownify $ docify parser
					_ -> error "Internal error"
			in
			if 
				output config == "stdout"
			then 
				putStrLn rendered
			else
				writeFile (output config) rendered))