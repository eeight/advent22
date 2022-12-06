import Data.List(nub)

main = (solve <$> getContents) >>= print where
    solve = go 4
    go n l
        | (== 4) . length . nub . take 4 $ l = n
        | otherwise = go (n + 1) (tail l)
