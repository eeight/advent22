import Data.List
import Debug.Trace

k = 811589153

main = (solve <$> getContents) >>= print where
    solve = getResult . scramble . map ((* k) . read) . lines

    --getResult .  scramble :: [Int] -> [Int]
    scramble xs = let
        n = length xs
        rs = [0..n - 1]

        move :: [(Int, Int)] -> Int -> [(Int, Int)]
        move s i = let
            ((_, x):s') = rotateTo i s
            dest = (x + (n - 1)*k) `mod` (n - 1)
            s''  = rotate dest s'
            in (i, x):s''

        rotate n s = let
            (x, y) = splitAt n s
            in y ++ x

        rotateTo i s = let
            (x, y) = break ((== i) . fst) s
            in y ++ x

        round yy = foldl' move yy rs

        in map snd $ iterate round (zip rs xs) !! 10

    getResult l = let
        ll = cycle l
        z = dropWhile (/= 0) ll
        _1 = drop 1000 z
        _2 = drop 1000 _1
        _3 = drop 1000 _2
        in sum $ map head $ [_1, _2, _3]
