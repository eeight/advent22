import Data.Array.Unboxed
import Data.List

type B = ((Int, Int), Char)

main = (solve <$> getContents) >>= print where
    solve input = let
        (bs, size, source, target) = parse input
        ss1 = iterate (nextState size source target) ([source], bs)
        (h1, t1) = break ((target `elem`) . fst) ss1
        bs1 = snd $ head t1
        ss2 = iterate (nextState size source target) ([target], bs1)
        (h2, t2) = break ((source `elem`) . fst) ss2
        bs2 = snd $ head t2
        ss3 = iterate (nextState size source target) ([source], bs2)
        (h3, t3) = break ((target `elem`) . fst) ss3
        in length (h1 ++ h2 ++ h3)

    parse input = let
        ls = lines input
        ysize = length ls
        xsize = length . head $ ls
        source = (0, length . takeWhile (/= '.') $ input)
        target = (ysize - 1, xsize - (length . takeWhile (/= '.') . reverse $ input))

        go y x [] = []
        go y x (f:fs)
            | f `elem` "<>^v" = ((y, x), f):go y (x + 1) fs
            | f == '\n' = go (y + 1) 0 fs
            | otherwise = go y (x + 1) fs

        in (go 0 0 input, (ysize, xsize), source, target)

    nextPos (y, x) = [(y, x), (y - 1, x), (y + 1, x), (y, x - 1), (y, x + 1)]

    nextState (ysize, xsize) source target (cs, bs) = let
        stepB :: B -> B
        stepB ((y, x), d) = let
            (y', x') = case d of
                '^' -> (y - 1, x)
                'v' -> (y + 1, x)
                '>' -> (y, x + 1)
                '<' -> (y, x - 1)


            wrap size x
                | x < 1 = size - 2
                | x >= size - 1 = 1
                | otherwise = x

            in ((wrap ysize y', wrap xsize x'), d)
        isGoodPos (y, x) = (y > 0 && x > 0 && y + 1 < ysize && x + 1 < xsize && not (bMap ! (y, x))) || (y, x) `elem` [source, target]
        bs' = map stepB bs
        bMap :: UArray (Int, Int) Bool = accumArray (\_ _ -> True) False ((0, 0), (ysize - 1, xsize - 1)) . map ((, ()) . fst) $ bs'
        cs' = nub . filter isGoodPos . concatMap nextPos $ cs

        in (cs', bs')
