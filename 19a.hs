import qualified Data.Map as M
import qualified Data.Set as S
import Data.List

type B = (Int, Int, (Int, Int), (Int, Int))
type I4 = (Int, Int, Int, Int)
type S = (I4, (Bool, Bool, Bool, Bool), I4)

main = (solve <$> getContents) >>= print where
    solve = product . map (getCount . parse) . take 3 . lines

    parse :: String -> B
    parse l = let
        ws = words l
        x :: Int -> Int
        x = read . (ws !!)
        in (x 6, x 12, (x 18, x 21), (x 27, x 30))

    next :: B -> S -> [S]
    next (x, y, (z', z''), (w', w'')) ((a, b, c, d), (a_, b_, c_, d_), counts@(i, j, k, l)) = let
        nc@(a', b', c', d') = (i + a, j + b, k + c, l + d)
        t4 = (True, True, True, True)
        may1 = a_ && a >= x && (i < x || i < y || i < z' || i < w')
        may2 = b_ && a >= y && (j < z'')
        may3 = c_ && a >= z' && b >= z'' && (k < w'')
        may4 = d_ && a >= w' && c >= w''
        a_' = a_ && not may1
        b_' = b_ && not may2
        c_' = c_ && not may3
        d_' = d_ && not may4
        in concat [
            if may1 then [((a' - x, b', c', d'), t4, (i + 1, j, k, l))] else [],
            if may2 then [((a' - y, b', c', d'), t4, (i, j + 1, k, l))] else [],
            if may3 then [((a' - z', b' - z'' , c', d'), t4, (i, j, k + 1, l))] else [],
            if may4 then [((a' - w', b', c' - w'', d'), t4, (i, j, k, l + 1))] else [],
            if a_' || b_' || c_' || d_' then [(nc, (a_', b_', c_', d_'), counts)] else []
        ]

    expectedGeodes n ((_, _, _, x), _, (_, _, _, y)) = x + y*n

    prune n ss = let
        gm = maximum . map (expectedGeodes n) $ ss
        offset = n * (n + 1) `div` 2
        in filter (\x -> expectedGeodes n x + offset > gm) ss

    getCount b = let
        begin = ((0, 0, 0, 0), (True, True, True, True), (1, 0, 0, 0))
        in maximum $ map (\((_, _, _, x), _, _) -> x) $ foldl (\s i -> prune i . concatMap (next b) $ s) [begin] [32,31..1]
