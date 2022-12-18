import Data.Array
import Data.List.Split
import Data.List

import Debug.Trace

type C = (Int, Int, Int)

liftC f (x, y, z) (a, b, c) = (f x a, f y b, f z c)

neighbors (x, y, z) = [
    (x - 1, y, z),
    (x + 1, y, z),
    (x, y - 1, z),
    (x, y + 1, z),
    (x, y, z - 1),
    (x, y, z + 1)]

main = (solve <$> getContents) >>= print where
    solve input = let
        cs = map parse . lines $ input
        cArray = toArray cs
        in getArea cs cArray

    parse :: String -> C
    parse l = let
        [x, y, z] = map read . splitOn "," $ l
        in (x, y, z)

    toArray cs = let
        low = foldl1' (liftC min) cs
        hi = foldl1' (liftC max) cs
        in accumArray (const $ const True) False (low, hi) $ map (, ()) cs

    getArea cs cArray = go 0 cs where
        bs = bounds cArray

        go acc [] = acc
        go acc (c:cs) = go (acc + 6 - sum (map lookup . neighbors $ c)) cs

        lookup :: C -> Int
        lookup c
            | inRange bs c = fromEnum $ cArray ! c
            | otherwise = 0
