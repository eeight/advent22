import Data.List(nub, transpose, sort)

main = (solve <$> getContents) >>= print where
    solve input = let
        ll = lines input
        solve' m = let
            k = length (head m) - 1
            mi = zip (map (0,) [0..]) m
            rmi = zip (map (k,) [0..]) . map reverse $ m
            in concatMap (uncurry $ indices (1, 0)) mi ++ concatMap (uncurry $ indices (-1, 0)) rmi
        in length . nub $ solve' ll ++ map (uncurry (flip (,))) (solve' $ transpose ll)

    indices step coord (x:xs) = go coord step [coord] x xs where
        go _ _ acc _ [] = acc
        go (i, j) step@(i', j') acc m (x:xs) = go next step acc' (max m x) xs where
            next = (i + i', j + j')
            acc'
                | x > m = next:acc
                | otherwise = acc
