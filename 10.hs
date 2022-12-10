main = (solve <$> getContents) >>= print where
    solve = sum . map (uncurry (*)) . take 6 . compute . trace 1 . lines

    trace x [] = repeat x
    trace x (l:ls) = case words l of
        ["addx", n] -> x:x:trace (x + read n) ls
        ["noop"] -> x:trace x ls

    compute xs = let
        xs' = drop 19 xs
        ns = map head . iterate (drop 40) $ xs'
        in zip (20:[60, 100..]) ns
