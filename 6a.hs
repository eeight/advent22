import Data.List(nub)

main = (solve <$> getContents) >>= print where
    solve = go 14
    go n l
        | (== 14) . length . nub . take 14 $ l = n
        | otherwise = go (n + 1) (tail l)
