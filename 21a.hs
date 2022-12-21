import qualified Data.Map as M

data E = H | A Int | O Char E E

main = (solve <$> getContents) >>= print where
    solve input = let
        m = M.fromList . map (f . words) . lines $ input

        at :: String -> E
        at x = let Just r = M.lookup x m in r

        f ["humn:", _] = ("humn", H)
        f [name, x] = (take 4 name, A $ read x)
        f [name, x, g:_, y] = let
            v = case (at x, at y) of
                (A x', A y') -> A $ op g x' y'
                (x', y') -> O g x' y'
            in (take 4 name, v)

        op '+' = (+)
        op '-' = (-)
        op '*' = (*)
        op '/' = div

        (e, x) = case at "root" of
            (O '+' (A x) e) -> (e, x)
            (O '+' e (A x)) -> (e, x)

        unright x y '+' = x - y
        unright x y '*' = x `div` y
        unright x y '-' = y - x
        unright x y '/' = y `div` x

        unleft x y '+' = x - y
        unleft x y '*' = x `div` y
        unleft x y '-' = x + y
        unleft x y '/' = x * y

        backtrack x H = x
        backtrack x tt@(O g (A y) v) = backtrack (unright x y g) v
        backtrack x tt@(O g u (A y)) = backtrack (unleft x y g) u

        in backtrack x e
