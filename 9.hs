import Data.Function(on)
import Data.List(sortBy, nub)

main = (solve <$> getContents) >>= print where
    solve = length . nub . go (0, 0) (0, 0) [] . unpack . lines
    -- solve = reverse . go (0, 0) (0, 0) [] . unpack . lines

    add (x, y) (x', y') = (x + x', y + y')
    sub (x, y) (x', y') = (x - x', y - y')


    unpack :: [String] -> [(Int, Int)]
    unpack [] = []
    unpack ((d:' ':n):ls) = let
        count :: Int = read n
        d' = case d of
            'L' -> (-1, 0)
            'R' -> (1, 0)
            'U' -> (0, -1)
            'D' -> (0, 1)
        in replicate (read n) d' ++ unpack ls

    go pos diff acc [] = (add pos diff):acc
    go pos diff acc (move:xs) = go (add pos move) (next $ sub diff move) ((add pos diff):acc) xs

    isClose = uncurry $ ((&&) `on` ((< 2) . abs))

    next pos | isClose pos = pos
    next (0, y) = (0, signum y)
    next (x, 0) = (signum x, 0)
    next pos = let
        moves = [(dx, dy) | dx <- [-1, 1], dy <- [-1,1]]
        isClose = uncurry $ ((&&) `on` ((< 2) . abs))
        in head . filter isClose . map (add pos) $ moves

