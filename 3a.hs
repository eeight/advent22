import Data.Char(ord)
import Data.List(foldl1')
import Data.List.Split(chunksOf)

main = (solve <$> getContents) >>= print where
    solve = sum . map (prio . common) . chunksOf 3 . lines
    prio x | x >= 'a' && x <= 'z' = ord x - ord 'a' + 1
    prio x | x >= 'A' && x <= 'Z' = ord x - ord 'A' + 27
    common = head . foldl1' (filter . flip elem)

