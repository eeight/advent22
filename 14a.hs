import Data.List.Split
import Control.Monad.ST
import Control.Monad(forM_, forM)
import Data.Array.MArray
import Data.Array.IArray
import Data.Array.ST(runSTArray, STArray)
import Data.STRef

main = (solve <$> getContents) >>= print where
    solve input = let
        coords = concatMap parse . lines $ input
        maxY = maximum . map snd $ coords
        floor = [(x, maxY + 2) | x <- [-1000..1000]]
        in 1 + runST (simulate (coords ++ floor))

    parse :: String -> [(Int, Int)]
    parse l = let
        readPoint s = let
            [x, y] = splitOn "," s
            in (read x, read y)

        interpolate (x, y) (x', y') = [(x'', y'') | x'' <- [min x x'..max x x'], y'' <- [min y y'..max y y']]
        points = map readPoint . splitOn " -> " $ l
        in concat $ zipWith interpolate points (tail points)

    range :: [Int] -> (Int, Int)
    range xs = (minimum xs, maximum xs)

    start :: (Int, Int)
    start = (500, 0)

    simulate :: [(Int, Int)] -> ST s Int
    simulate coords = do
        let (minX, maxX) :: (Int, Int) = range . map fst $ start:coords
        let (minY, maxY) = range . map snd $ start:coords
        f <- newArray ((minX, minY), (maxX, maxY)) True
        forM_ coords $ \c -> writeArray f c False
        go 0 f

    go :: Int -> STArray s (Int, Int) Bool -> ST s Int
    go counter f = do
        c <- drop start f
        if c == start
            then return counter
            else writeArray f c False >> go (counter + 1) f

    drop :: (Int, Int) -> STArray s (Int, Int) Bool -> ST s (Int, Int)
    drop c f = do
        let (x, y) = c
        let ns = [(x, y + 1), (x - 1, y + 1), (x + 1, y + 1)]
        cs <- forM ns $ \c -> readArray f c
        if or cs
            then let
                c' = fst . head . filter snd $ zip ns cs
                in drop c' f
            else return c
