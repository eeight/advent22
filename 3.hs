import Data.Char(ord)

main = (solve <$> getContents) >>= print where
    solve = sum . map (prio . common) . lines
    prio x | x >= 'a' && x <= 'z' = ord x - ord 'a' + 1
    prio x | x >= 'A' && x <= 'Z' = ord x - ord 'A' + 27
    common l = let
        (lhs, rhs) = splitAt (length l `div` 2) l
        in head $ filter (`elem` rhs) lhs

