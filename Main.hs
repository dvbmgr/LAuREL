import LAuREL.Types
import LAuREL.Parser
import System.Environment

main :: IO ()
main = 
	getArgs >>= readFile . head >>= print . parseLAuREL 