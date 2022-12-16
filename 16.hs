import Data.List
import Data.Char
import Data.Bits
import Data.Array

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

        next :: (Int, Int, Int, Int) -> [(Int, Int, Int, Int)]
        next (v, isOpen, openSum, totalSum) = let
            totalSum' = totalSum + openSum
            o = if testBit isOpen v
                then []
                else [(v, setBit isOpen v, openSum + (rates ! v), totalSum')]
            es = map (\w -> (w, isOpen, openSum, totalSum')) $ outEdges ! v
            in o ++ es

        groupStates = map (maximumBy (\(_, _, _, s1) (_, _, _, s2) -> compare s1 s2)) . groupBy (\(x, y, _, _) (a, b, _, _) -> x == a && y == b) . sort

        initOpen :: Int
        initOpen = sum  . map (\(i, (r, _)) -> setBit 0 i * fromEnum (r == 0)) . zip [0..] $ g

        states = iterate (groupStates . concatMap next) [(0, initOpen, 0, 0)] !! 30
        in maximum . map (\(_, _, _, s) -> s) $ states
