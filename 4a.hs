import Data.List.Split(splitOn)

main = (solve <$> getContents) >>= print where
    solve = length . filter (uncurry overlap) . map parse . lines
    parse s = let
        parse2 :: String -> (Int, Int)
        parse2 s = let [x, y] = map read . splitOn "-" $ s in (x, y)
        [x, y] = map parse2 . splitOn "," $ s
        in (x, y)

    overlap (b1, e1) (b2, e2) = max b1 b2 <= min e1 e2
