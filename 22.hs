import Data.Array.Unboxed
import Data.List
import Data.Char
import Data.Maybe

import Debug.Trace

data P = Go Int | Turn Int deriving Show

type A = UArray (Int, Int) Char
type C = (Int, Int, Int)

main = (solve <$> getContents) >>= print where
    solve input = let
        (field, commands) = parse . lines $ input
        (sy, sx) = startCoord field
        (y, x, d) = foldl' (move field) (sy, sx, 0) commands
        in y * 1000 + x * 4 + d

    parse :: [String] -> (A, [P])
    parse ls = let
        (fls, _:[is]) = break (== "") ls
        xs = 2 + maximum (map length fls)
        ys = 2 + length fls
        xpad = replicate xs ' '
        field = traceShow (xs, ys) $ listArray ((0, 0), (ys - 1, xs - 1)) . concat $ [xpad] ++ map (\l -> take xs $  " " ++ l ++ repeat ' ') fls ++ [xpad]

        pp [] = []
        pp ('L':xs) = Turn (-1):pp xs
        pp ('R':xs) = (Turn 1):pp xs
        pp xs = let
            (ns, xs') = break (not . isDigit) xs
            in Go (read ns):pp xs'

        in (field, pp is)

    startCoord :: A -> (Int, Int)
    startCoord field = fromJust . find (\c -> (field ! c) == '.') . map (1,) $ [0..]

    move :: A -> C -> P -> C
    move field (y, x, d) (Turn t) = (y, x, (d + t + 4) `mod` 4)
    move field (y, x, d) (Go 0) = (y, x, d)
    move field (y, x, d) (Go n) = traceShow (y, x, d) $ let
        (dy, dx) = case d of
            0 -> (0, 1)
            1 -> (1, 0)
            2 -> (0, -1)
            3 -> (-1, 0)

        wrap d y x = let
            (_, (ymax, xmax)) = bounds field
            mkCoords = case d of
                0 -> (y,)
                1 -> (,x)
                2 -> \i -> (y, xmax - i)
                3 -> \i -> (ymax - i, x)

            in fromJust . find (\c -> (field ! c) /= ' ') $ map mkCoords [0..]

        go y x = let
            (y', x') = (y + dy, x + dx)
            in case traceShow ("index", y', x') (traceShowId $ field ! (y', x')) of
                '.' -> (y', x')
                '#' -> (y, x)
                ' ' -> let
                    (y', x') = wrap d y x
                    in if field ! (y', x') == '#' then (y, x) else (y', x')

        (y', x') = go y x
        in move field (y', x', d) (Go (n - 1))
