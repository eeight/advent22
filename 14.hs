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
        in runST (simulate coords)

    parse :: String -> [(Int, Int)]
    parse l = let
        readPoint s = let
            [x, y] = splitOn "," s
            in (read x, read y)

        interpolate (x, y) (x', y') = [(x'', y'') | x'' <- [min x x'..max x x'], y'' <- [min y y'..max y y']]
        points = map readPoint . splitOn " -> " $ l
        in concat $ zipWith interpolate points (tail points)

    range xs = (minimum xs, maximum xs)

    start = (500, 0)

    simulate :: [(Int, Int)] -> ST s Int
    simulate coords = do
        let (minX, maxX) :: (Int, Int) = range . map fst $ start:coords
        let (minY, maxY) = range . map snd $ start:coords
        let bounds = ((minX, minY), (maxX, maxY))
        f <- newArray bounds True
        forM_ coords $ \c -> writeArray f c False
        go bounds 0 f

    go :: ((Int, Int), (Int, Int)) -> Int -> STArray s (Int, Int) Bool -> ST s Int
    go bounds counter f = do
        res <- drop bounds start f
        case res of
            Nothing -> return counter
            Just c -> writeArray f c False >> go bounds (counter + 1) f

    inBounds' (a, b) c = c >= a && c <= b
    inBounds ((x0, y0), (x1, y1)) (x, y) = inBounds' (x0, x1) x && inBounds' (y0, y1) y

    drop :: ((Int, Int), (Int, Int)) -> (Int, Int) -> STArray s (Int, Int) Bool -> ST s (Maybe (Int, Int))
    drop bounds c f = do
        let getf c = if inBounds bounds c then readArray f c else return True
        if inBounds bounds c
            then do
                let (x, y) = c
                let ns = [(x, y + 1), (x - 1, y + 1), (x + 1, y + 1)]
                cs <- forM ns $ \c -> getf c
                if or cs
                    then let
                        c' = fst . head . filter snd $ zip ns cs
                        in drop bounds c' f
                    else return $ Just c

            else return Nothing
