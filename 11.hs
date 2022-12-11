import Control.Monad(forM_)
import Control.Monad.ST
import Data.Array.MArray
import Data.Array.IArray
import Data.Array.ST(runSTArray, STArray)
import Data.Foldable(toList)
import Data.List.Split(splitOn)
import Data.Sequence(Seq(Empty, (:|>)))
import Data.List(sort)
import qualified Data.Sequence as S

data Monkey = Monkey { items :: Seq Int, next :: Int -> Int, test :: (Int, Int, Int), count :: Int }
main = (solve <$> getContents) >>= print where
    solve = product . take 2 . reverse . sort . map count . solveMonkeys . parse

    solveMonkeys monkeys = toList $ runSTArray $ do
        arr <- newListArray (0, length monkeys - 1) monkeys
        sequence_ $ replicate 20 $ nextRound arr
        return arr

    nextRound :: STArray s Int Monkey -> ST s ()
    nextRound monkeys = do
        (b, e)  <- getBounds monkeys
        sequence_ [nextRound1 i monkeys | i <- [b..e]]

    nextRound1 i monkeys = do
        source <- readArray monkeys i
        forM_ (toList . items $ source) $ \val -> do
            let val' = next source val `div` 3
            let (d, t, e) = test source
            let target = if val' `mod` d == 0 then t else e
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
                test = (last_int if_expr, last_int if_true, last_int if_false),
                count = 0
            }
            in monkey:go (drop 7 ls)
