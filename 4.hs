import Data.List.Split(splitOn)

main = (solve <$> getContents) >>= print where
    solve = length . filter (uncurry anyContains) . map parse . lines
    parse s = let
        parse2 :: String -> (Int, Int)
        parse2 s = let [x, y] = map read . splitOn "-" $ s in (x, y)
        [x, y] = map parse2 . splitOn "," $ s
        in (x, y)

    contains (b1, e1) (b2, e2) = b2 >= b1 && e2 <= e1
    anyContains x y = contains x y || contains y x
