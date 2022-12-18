import Data.Array.Unboxed
import Data.List.Split
import Data.List
import Data.Array.ST
import Control.Monad.ST
import Control.Monad

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
        steam = fill cArray
        in getArea cs steam

    parse :: String -> C
    parse l = let
        [x, y, z] = map read . splitOn "," $ l
        in (x, y, z)

    toArray :: [C] -> UArray C Bool
    toArray cs = let
        offset = (1, 1, 1)
        low = liftC (flip (-)) offset $ foldl1' (liftC min) cs
        hi = liftC (+) offset $ foldl1' (liftC max) cs
        in accumArray (const $ const True) False (low, hi) $ map (, ()) cs

    getArea :: [C] -> UArray C Bool -> Int
    getArea cs steam = go 0 cs where
        go acc [] = acc
        go acc (c:cs) = go (acc + sum (map (fromEnum . (steam !)) . neighbors $ c)) cs

    fill cArray = runSTUArray $ do
        let bs = bounds cArray
        visited <- newArray bs False

        let go cs = do
                let cs' = nub $ filter (inRange bs) cs
                ucs <- filterM (fmap not . readArray visited) cs'
                let ucs' = filter (not . (cArray !)) ucs
                when (not $ null ucs') $ do
                    mapM_ (flip (writeArray visited) True) ucs'
                    go $ concatMap neighbors ucs'

        go [(0, 0, 0)]
        return visited
