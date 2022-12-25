main = (solve <$> getContents) >>= putStrLn where
    solve = encode . sum . map (decode 0) . lines

    decode :: Int -> String -> Int
    decode n [] = n
    decode n (x:xs) = decode (n * 5 + d) xs where
        d = case x of
            '2' -> 2
            '1' -> 1
            '0' -> 0
            '-' -> -1
            '=' -> -2

    encode = reverse . go where
        go 0 = ""
        go n = let
            n5 = n `mod` 5
            c = "012=-" !! n5
            carry = fromEnum $ n5 >= 3
            in c:go (n `div` 5 + carry)
