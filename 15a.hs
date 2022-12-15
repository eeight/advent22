import Data.Maybe
import Data.List

import qualified Data.Set as S

import Debug.Trace

main = (solve <$> getContents) >>= print where
    bound = 4000000
    -- bound = 20

    solve input = let
        points = map parse . lines $ input
        checkLine i = fmap (,i) . findEmpty . catMaybes . map (uncurry (project i)) $ points
        (x, y) = head . catMaybes . map checkLine $ [0..bound]
        x' :: Integer = fromIntegral x
        y' :: Integer = fromIntegral y
        in x' * 4000000 + y'



    parse :: String -> ((Int, Int), (Int, Int))
    parse line = let
        ws = words line
        r = read . filter (`elem` "0123456789-") . (ws !!)
        in ((r 2, r 3), (r 8, r 9))

    dist (x, y) (a, b) = abs (x - a) + abs (y - b)

    coordBound x = x >= 0 && x <= bound

    project :: Int -> (Int, Int) -> (Int, Int) -> Maybe (Int, Int)
    project n p@(x, y) b = let
        d = dist p b
        line_d = abs (y - n)
        span = d - line_d
        in if span < 0
            then Nothing
            else Just (x - span, x + span)

    findEmpty :: [(Int, Int)] -> Maybe Int
    findEmpty = go (-1) . sort where
        go pos _ | pos >= bound = Nothing
        go pos [] = Just $ pos + 1
        go pos ((b, e):xs)
            | b <= pos + 1 = go (max e pos) xs
            | otherwise = Just $ pos + 1

