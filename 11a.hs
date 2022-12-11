import Control.Monad(forM_)
import Control.Monad.ST
import Data.Array.MArray
import Data.Array.IArray
import Data.Array.ST(runSTArray, STArray)
import Data.Foldable(toList)
import Data.List.Split(splitOn)
import Data.Sequence(Seq(Empty, (:|>)))
import Data.List(sort, foldl1')
import qualified Data.Sequence as S

data Monkey = Monkey { items :: Seq Int, next :: Int -> Int, test_d :: Int, test_t :: Int, test_e ::Int, count :: Int }
main = (solve <$> getContents) >>= print where
    solve input = let
        monkeys = parse input
        limit = foldl1' lcm . map test_d $ monkeys
        in product . take 2 . reverse . sort . map count $ solveMonkeys limit monkeys

    solveMonkeys limit monkeys = toList $ runSTArray $ do
        arr <- newListArray (0, length monkeys - 1) monkeys
        sequence_ $ replicate 10000 $ nextRound limit arr
        return arr

    nextRound limit monkeys = do
        (b, e)  <- getBounds monkeys
        sequence_ [nextRound1 limit i monkeys | i <- [b..e]]

    nextRound1 limit i monkeys = do
        source <- readArray monkeys i
        forM_ (toList . items $ source) $ \val -> do
            let val' = next source val `mod` limit
            let target = if val' `mod` (test_d source) == 0 then (test_t source) else (test_e source)
            modifyAt monkeys target $ \dest -> dest { items = items dest :|> val'}
        writeArray monkeys i $ source { items = Empty, count = count source + length (items source) }

    modifyAt a i f = do
        x <- readArray a i
        writeArray a i (f x)

    parse = go . lines where
        go ls | length ls < 6 = []
        go ls = let
            _:starting_items:operation:if_expr:if_true:if_false:_ = take 7 ls
            [_, items'] = splitOn ": " starting_items
            [_, operation'] = splitOn "= " operation
            [_, op, arg] = words operation'
            op' = case op of
                "+" -> (+)
                "*" -> (*)
            arg' = case arg of
                "old" -> id
                x -> const (read x)
            last_int = read . last . words
            monkey = Monkey {
                items = S.fromList . map read . splitOn ", " $ items',
                next = \old -> op' old (arg' old),
                test_d = last_int if_expr,
                test_t = last_int if_true,
                test_e = last_int if_false,
                count = 0
            }
            in monkey:go (drop 7 ls)
