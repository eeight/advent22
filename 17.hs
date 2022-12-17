import Control.Monad
import Control.Monad.ST
import Data.Array.ST
import Data.Array
import Data.STRef

import Debug.Trace

pop x = do
    result <- head <$> readSTRef x
    modifySTRef x tail
    return result

shapes = [
    [(0, 0), (1, 0), (2, 0), (3, 0)],
    [(1, 0), (0, 1), (1, 1), (2, 1), (1, 2)],
    [(0, 0), (1, 0), (2, 0), (2, 1), (2, 2)],
    [(0, 0), (0, 1), (0, 2), (0, 3)],
    [(0, 0), (1, 0), (0, 1), (1, 1)]]

shapeHeight = (+ 1) . maximum . map snd

plus (x, y) (a, b) = (x + a, y + b)

withinBounds ((x0, y0), (x1, y1)) (x, y) = check x0 x1 x && check y0 y1 y where
    check x0 x1 x = x >= x0 && x <= x1

applyMove '<' (x, y) = (x - 1, y)
applyMove '>' (x, y) = (x + 1, y)
oneDown (x, y) = (x, y - 1)

type C = (Int, Int)

na :: (C, C) -> ST s (STUArray s C Bool)
na bs = newArray bs False

main = (solve <$> getContents) >>= print where
    solve = simulate 2022 . takeWhile (`elem` "<>")

    simulate stepCount moves_ = runST $ do
        let bounds = ((0, 0), (6, stepCount * 4 + 10))
        field <- na bounds
        movesRef <- newSTRef $ cycle moves_
        shapesRef <- newSTRef $ cycle shapes
        heightRef <- newSTRef (0 :: Int)

        let isGood (offset :: C) (shape :: [C]) = do
                let shape' = map (plus offset) shape
                if all (withinBounds bounds) shape'
                    then (not . or) <$> (mapM (readArray field) shape')
                    else return False

        let go shape offset = do
                m <- pop movesRef
                let offset' = applyMove m offset
                mayMove <- isGood offset' shape
                let offset'' = if mayMove then offset' else offset
                let offset''' = oneDown offset''
                -- try fall
                mayFall <- isGood offset''' shape
                if mayFall
                    then go shape offset'''
                    else return $ offset''


        let dropOne = do
                shape <- pop shapesRef
                prevHeight <- readSTRef heightRef
                offset <- go shape (2, prevHeight + 3)
                forM_ (map (plus offset) shape) $ \c -> writeArray field c True
                writeSTRef heightRef $ max prevHeight (snd offset + shapeHeight shape)

        replicateM_ stepCount dropOne
        readSTRef heightRef
