main = (solve <$> getContents) >>= putStrLn where
    solve = unlines . take 6 . map mkLine . (iterate $ drop 40) . trace 1 . lines

    trace x [] = repeat x
    trace x (l:ls) = case words l of
        ["addx", n] -> x:x:trace (x + read n) ls
        ["noop"] -> x:trace x ls

    mkLine xs = zipWith pixel xs [0..39] where
        pixel x y
            | abs (x - y) < 2 = '#'
            | otherwise = '.'
