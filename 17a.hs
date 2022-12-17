import Control.Monad
import Control.Monad.ST
import Data.Array.ST
import Data.Array
import Data.STRef
import Data.Bits

import qualified Data.Map as M

next :: STRef s Int -> Int -> ST s Int
next x max = do
    result <- readSTRef x
    modifySTRef' x ((`mod` max) . (+ 1))
    return result

shapes = [
    [(0, 0), (1, 0), (2, 0), (3, 0)],
    [(1, 0), (0, 1), (1, 1), (2, 1), (1, 2)],
    [(0, 0), (1, 0), (2, 0), (2, 1), (2, 2)],
    [(0, 0), (0, 1), (0, 2), (0, 3)],
    [(0, 0), (1, 0), (0, 1), (1, 1)]]

shapeCount :: Int = length shapes
shapeArray = listArray (0, shapeCount - 1) shapes

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
    solve input = let
        moves = takeWhile (`elem` "<>") $ input
        moveArray = listArray (0, length moves - 1) moves
        in simulate (1000000000000 :: Integer) moveArray

    simulate stepCount moves = runST $ do
        let moveCount = ((+ 1) . snd) $ Data.Array.bounds moves
        let bounds = ((0, 0), (6, 1000000 * 4 + 10))
        field <- na bounds
        moveIndex <- newSTRef (0 :: Int)
        shapeIndex <- newSTRef (0 :: Int)
        heightRef <- newSTRef (0 :: Int)

        seenStates <- newSTRef M.empty

        let isGood (offset :: C) (shape :: [C]) = do
                let shape' = map (plus offset) shape
                if all (withinBounds bounds) shape'
                    then (not . or) <$> (mapM (readArray field) shape')
                    else return False

        let go shape offset = do
                m <- next moveIndex moveCount
                let offset' = applyMove (moves ! m) offset
                mayMove <- isGood offset' shape
                let offset'' = if mayMove then offset' else offset
                let offset''' = oneDown offset''
                -- try fall
                mayFall <- isGood offset''' shape
                if mayFall
                    then go shape offset'''
                    else return $ offset''

        let signature stepIndex = do
                si <- readSTRef shapeIndex
                mi <- readSTRef moveIndex
                h <- readSTRef heightRef
                let xSignature x = do
                        bits <- forM [0..1] $ \ y -> if h > y then readArray field (x, h - y - 1) else return True
                        return $ sum [(1 `shiftL` i) * fromEnum b | (i, b) <- zip [0..] bits]
                xSignatures <- mapM xSignature [0..6]
                if any (== 0) xSignatures
                    then return $ - (fromInteger stepIndex)
                    else return $ (mi * shapeCount + si) + sum [(xs `mod` 2) `shiftL` (16 + i*6) | (i, xs) <- zip [0..6] xSignatures]

        let dropOne = do
                s :: Int <- next shapeIndex shapeCount
                let shape = shapeArray ! s
                prevHeight <- readSTRef heightRef
                offset <- go shape (2, prevHeight + 3)
                forM_ (map (plus offset) shape) $ \c -> writeArray field c True
                writeSTRef heightRef $ max prevHeight (snd offset + shapeHeight shape)

        let dropOneLoop stepIndex
                | stepIndex == stepCount = fromIntegral <$> readSTRef heightRef
                | otherwise = do
                    s <- signature stepIndex
                    seen <- readSTRef seenStates
                    h <- readSTRef heightRef
                    let cont = do
                            writeSTRef seenStates $ M.insert s (h, stepIndex) seen
                            dropOne
                            dropOneLoop (stepIndex + 1)
                    let r = if s < 0 then Nothing else M.lookup s seen
                    case r of
                        Nothing -> cont
                        Just (prevH, prevStepIndex) -> let
                                loopLen = stepIndex - prevStepIndex
                                heightIncrease = h - prevH
                                (loopCount, steps) = (stepCount - stepIndex) `divMod` loopLen
                                (prevH', _) = head $ dropWhile ((/= prevStepIndex + steps) . snd) $ M.elems seen
                                hResult :: Integer = fromIntegral h + (fromIntegral heightIncrease * fromIntegral loopCount) + fromIntegral (prevH' - prevH)
                                in return hResult
        dropOneLoop 0
