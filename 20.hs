import Data.List
import Debug.Trace

main = (solve <$> getContents) >>= print where
    solve = getResult . scramble . map read . lines
    -- solve = scramble . map read . lines

    --getResult .  scramble :: [Int] -> [Int]
    scramble xs = let
        n = length xs
        rs = [0..n - 1]

        move :: [(Int, Int)] -> Int -> [(Int, Int)]
        move s i = let
            ((_, x):s') = rotateTo i s
            dest = (x + n - 1) `mod` (n - 1)
            s''  = rotate dest s'
            in (i, x):s''

        rotate n s = let
            (x, y) = splitAt n s
            in y ++ x

        rotateTo i s = let
            (x, y) = break ((== i) . fst) s
            in y ++ x

        xs'' = foldl' move (zip rs xs) rs
        in map snd xs''

    getResult l = let
        ll = cycle l
        z = dropWhile (/= 0) ll
        _1 = drop 1000 z
        _2 = drop 1000 _1
        _3 = drop 1000 _2
        in sum $ map head $ [_1, _2, _3]
