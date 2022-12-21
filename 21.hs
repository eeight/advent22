import qualified Data.Map as M

main = (solve <$> getContents) >>= print where
    solve input = let
        m = M.fromList . map (f . words) . lines $ input

        at :: String -> Int
        at x = let Just r = M.lookup x m in r

        f [name, x] = (take 4 name, read x)
        f [name, x, g, y] = (take 4 name, op g (at x) (at y))

        op "+" = (+)
        op "-" = (-)
        op "*" = (*)
        op "/" = div

        in at "root"
