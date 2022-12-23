import Data.List
import qualified Data.Set as S
import qualified Data.Map as M

import Debug.Trace

type C = (Int, Int)
type D = C -> ([C], C)

main = (solve <$> getContents) >>= print where
    solve input = let
        coords = parse input
        ds = [n, s, w, e]
        dsRot = init $ zipWith (++) (tails ds) (inits ds)
        go n (d:ds) cs = let
            cs' = move cs d
            in if cs' == cs then n else go (n + 1) ds cs'
        in go 1 (cycle dsRot) coords

    parse :: String -> [C]
    parse = go 0 0 where
        go x y [] = []
        go x y ('.':cs) = go (x + 1) y cs
        go x y ('#':cs) = (x, y):go (x + 1) y cs
        go x y ('\n':cs) = go 0 (y + 1) cs

    move positions ds = let
        ps = S.fromList positions
        propose :: C -> C
        propose (x, y)
            | not  $ or [S.member (x + dx, y + dy) ps | dx <- [-1..1], dy <- [-1..1], (dx, dy) /= (0, 0)] = (x, y)
        propose c = let
            validMove d = not $ any (`S.member` ps) $ fst $ d c
            in case dropWhile (not . validMove) ds of
                [] -> c
                x:_ -> snd $ x c
        proposed = map propose positions
        proposed' = M.fromListWith (+) (map (,1) proposed)
        doMove c c' = case M.lookup c' proposed' of
            Just 1 -> c'
            otherwise -> c
        in zipWith doMove positions proposed

    n (x, y) = ([(x - 1, y - 1), (x, y - 1), (x + 1, y - 1)], (x, y - 1))
    s (x, y) = ([(x - 1, y + 1), (x, y + 1), (x + 1, y + 1)], (x, y + 1))
    w (x, y) = ([(x - 1, y - 1), (x - 1, y), (x - 1, y + 1)], (x - 1, y))
    e (x, y) = ([(x + 1, y - 1), (x + 1, y), (x + 1, y + 1)], (x + 1, y))
