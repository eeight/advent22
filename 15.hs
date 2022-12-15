import Data.Maybe
import Data.List

import qualified Data.Set as S

main = (solve <$> getContents) >>= print where
    n = 2000000

    solve input = let
        points = map parse . lines $ input
        s = aggregate . catMaybes . map (uncurry (project n)) $ points
        beacons = S.fromList . map fst . filter ((== n) . snd) . map snd $ points
        in S.size $ s `S.difference` beacons


    parse :: String -> ((Int, Int), (Int, Int))
    parse line = let
        ws = words line
        r = read . filter (`elem` "0123456789-") . (ws !!)
        in ((r 2, r 3), (r 8, r 9))

    dist (x, y) (a, b) = abs (x - a) + abs (y - b)

    project :: Int -> (Int, Int) -> (Int, Int) -> Maybe (Int, Int)
    project n p@(x, y) b = let
        d = dist p b
        line_d = abs (y - n)
        span = d - line_d
        in if span < 0
            then Nothing
            else Just (x - span, x + span)

    aggregate = S.fromList . concatMap (\(x, y) -> [x..y])
