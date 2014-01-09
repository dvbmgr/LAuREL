import LAuREL.Types
import LAuREL.Parser
import LAuREL.Eval
import System.Environment

main :: IO ()
main = 
	getArgs >>= readFile . head >>= evalulateLAuREL . parseLAuREL 