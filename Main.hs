import LAuREL.Types
import LAuREL.Parser
import LAuREL.Eval
import LAuREL.Lib
import System.Environment
import Data.Functor

main :: IO ()
main = do
	parser <- parseLAuREL <$> (getArgs >>= readFile . head)
	eval <- evaluateLAuREL stdlib parser 
	return ()