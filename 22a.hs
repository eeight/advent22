import Data.Array.Unboxed
import Data.List
import Data.Char
import Data.Maybe
import qualified Data.Map as M

data P = Go Int | Turn Int deriving Show

type A = UArray (Int, Int) Char
type C = (Int, Int, Int)
type JM = M.Map (Int, Int, Int) (Int, Int, Int)


main = (solve <$> getContents) >>= print where
    solve input = let
        (field, commands) = parse . lines $ input
        (sy, sx) = startCoord field
        m = M.fromList . jumpMap . (`div` 3) . snd . snd . bounds $ field
        (y, x, d) = foldl' (move field m) (sy, sx, 0) commands
        in y * 1000 + x * 4 + d

    parse :: [String] -> (A, [P])
    parse ls = let
        (fls, _:[is]) = break (== "") ls
        xs = 2 + maximum (map length fls)
        ys = 2 + length fls
        xpad = replicate xs ' '
        lll = concat $ [xpad] ++ map (\l -> take xs $  " " ++ l ++ repeat ' ') fls ++ [xpad]
        field = listArray ((0, 0), (ys - 1, xs - 1)) $ lll

        pp [] = []
        pp ('L':xs) = Turn (-1):pp xs
        pp ('R':xs) = (Turn 1):pp xs
        pp xs = let
            (ns, xs') = break (not . isDigit) xs
            in Go (read ns):pp xs'

        in (field, pp is)

    startCoord :: A -> (Int, Int)
    startCoord field = fromJust . find (\c -> (field ! c) == '.') . map (1,) $ [0..]

    dd 0 = (0, 1)
    dd 1 = (1, 0)
    dd 2 = (0, -1)
    dd 3 = (-1, 0)

    move :: A -> JM -> C -> P -> C
    move field _ (y, x, d) (Turn t) = (y, x, (d + t + 4) `mod` 4)
    move field _ (y, x, d) (Go 0) = (y, x, d)
    move field jm (y, x, d) (Go n) = let
        (dy, dx) = dd d

        go y x = let
            (y', x') = (y + dy, x + dx)
            in case field ! (y', x') of
                '.' -> (y', x', d)
                '#' -> (y, x, d)
                ' ' -> let
                    (y', x', d') = fromJust $ M.lookup (y, x, d) jm
                    in if field ! (y', x') == '#' then (y, x, d) else (y', x', d')

        (y', x', d') = go y x
        in move field jm (y', x', d') (Go (n - 1))

    jumpMap s = let
        span = [1..s]
        f i x = s * i + x
        r i x = s * (i + 1) - x + 1
        mirror ((y, x, d), (y', x', d')) = ((y', x', (d' + 2) `mod` 4), (y, x, (d + 2) `mod` 4))
        half = concat [
            [((f 0 1, f 1 x, 3), (f 3 x, f 0 1, 0)) | x <- span], -- 0
            [((f 4 0, f 0 x, 1), (f 0 1, f 2 x, 1)) | x <- span], -- 1
            [((f 1 0, f 2 x, 1), (f 1 x, f 2 0, 2)) | x <- span], -- 2
            [((f 1 x, f 1 1, 2), (f 2 1, f 0 x, 1)) | x <- span], -- 3
            [((f 2 x, f 0 1, 2), (r 0 x, f 1 1, 0)) | x <- span], -- 4
            [((f 3 0, f 1 x, 1), (f 3 x, f 1 0, 2)) | x <- span], -- 5
            [((f 2 x, f 2 0, 0), (r 0 x, f 3 0, 2)) | x <- span], -- 6
            []]

        in half ++ map mirror half
