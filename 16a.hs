import Data.List
import Data.Char
import Data.Bits
import Data.Array
import Data.Function

data State = State { u :: !Int, v :: !Int, isOpen :: !Int, openSum :: !Int, totalSum :: !Int}

compare1 !x !y = (v x `compare` v y) `mappend` (u x `compare` u y) `mappend` (isOpen x `compare` isOpen y) `mappend` (openSum x `compare` openSum y) `mappend` (totalSum y `compare` totalSum x)

main = (solve <$> getContents) >>= print where
    solve = getMax . parse . lines

    parse :: [String] -> [(Int, [Int])]
    parse = go [] where
        go acc [] = let
            vertices = sort . map (\(x, _, _) -> x) $ acc
            index v = fst . head . dropWhile ((/= v) . snd) . zip [0..] $ vertices
            in map (\(v, rate, ws) -> (rate, map index ws)) . sort $ acc

        go acc (l:ls) = let
            (_:v:_:_:rate:_:_:_:_:ws) = words l
            rate' = read . takeWhile isDigit . dropWhile (not . isDigit) $ rate
            ws' = map (take 2) ws
            in go ((v, rate', ws'):acc) ls

    getMax g = let
        outEdges :: Array Int [Int]
        outEdges = listArray (0, length g - 1) . map snd $ g
        rates :: Array Int Int
        rates = listArray (0, length g - 1) . map fst $ g

        next :: State -> [State]
        next s = let
            totalSum' = totalSum s + openSum s
            next1 x isOpen openSum = let
                o = if testBit isOpen x
                    then []
                    else [(x, setBit isOpen x, openSum + (rates ! x))]
                es = map (\w -> (w, isOpen, openSum)) $ outEdges ! x
                in o ++ es
            in do
                (v', isOpen', openSum') <- next1 (v s) (isOpen s) (openSum s)
                (u', isOpen'', openSum'') <- next1 (u s) isOpen' openSum'
                return $ State (min u' v') (max u' v') isOpen'' openSum'' totalSum'

        groupStates ss = let
            ss' = take 10000 . sortBy ((flip compare) `on` totalSum). map head . groupBy (\x y -> v x == v y && u x == u y && isOpen x == isOpen y) . sortBy compare1 $ ss
            in foldl1 seq ss' `seq` ss'

        initOpen :: Int
        initOpen = sum  . map (\(i, (r, _)) -> setBit 0 i * fromEnum (r == 0)) . zip [0..] $ g

        states = iterate (groupStates . concatMap next) [State 0 0 initOpen 0 0] !! 26
        in maximum . map totalSum $ states
