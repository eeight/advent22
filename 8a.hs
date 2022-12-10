import Data.List(nub, transpose, sort)

main = (solve <$> getContents) >>= print where
    solve input = let
        rows = lines input
        cols = transpose rows

        in maximum $ map (product . map score) $ do
            (i, row) <- zip [0..] rows
            (j, col) <- zip [0..] cols
            let (rl, rr) = cutAt j row
            let (cl, cr) = cutAt i col
            return [rl, rr, cl, cr]


    cutAt n l = let
        (lhs, x:rhs) = splitAt n l
        in (x:reverse lhs, x:rhs)

    score (x:xs) = go 0 x xs where
        go n _ [] = n
        go n k (x:xs)
            | k > x = go (n + 1) k xs
            | otherwise = n + 1
