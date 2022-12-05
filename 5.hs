main = (solve <$> getContents) >>= putStrLn where
    solve input = let
        ls = lines input
        stackCount = ((length $ head ls) + 1) `div` 4
        (ss, moves) = readStacks (replicate stackCount []) ls
        in map head $ applyMoves moves ss

    readStacks :: [String] -> [String] -> ([String], [String])
    readStacks ss ((_:'1':_):_:ts) = (map (reverse . filter (/= ' ')) ss, ts)
    readStacks ss (l:ls) = readStacks (zipWith (:) (map (l !!) [1, 5 .. length l]) ss) ls

    applyMoves :: [String] -> [String] -> [String]
    applyMoves [] ss = ss
    applyMoves (move:ms) ss = let
        [_, c, _, f, _, t] = words move
        c' = read c
        f' = read f - 1
        t' = read t - 1
        (piece, ff') :: (String, String) = splitAt c' (ss !! f')
        tt' :: String = reverse piece ++ (ss !! t')
        ss' = replace f' ff' $ replace t' tt' $ ss
        in applyMoves ms ss'

    replace :: Int -> a -> [a] -> [a]
    replace i e l = let
        (s, _:t) = splitAt i l
        in s ++ [e] ++ t
