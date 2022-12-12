import Data.Graph.AStar
import qualified Data.HashSet as S
import Data.Char(ord)

main = (solve <$> getContents) >>= print where
    solve input = let
        field = lines input
        m = length field
        n = length (head field)
        init = head $ [(x, y) | y <- [0..m - 1], x <- [0..n - 1], field !! y !! x == 'S']

        next (x, y) = filter valid [(x - 1, y), (x + 1, y), (x, y - 1), (x, y + 1)] where
            valid (x', y') = x' >= 0 && x' < n && y' >= 0 && y' < m && h (field !! y' !! x') <= h (field !! y !! x) + 1
            h 'S' = h 'a'
            h 'E' = h 'z'
            h c = ord c

        Just path =  aStar
            (S.fromList . next)
            (\_ _ -> 1)
            (const 0)
            (\(x, y) -> (field !! y) !! x == 'E')
            init
        in length path
