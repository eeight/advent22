import Data.Functor((<&>))
import Data.Char(ord)

main = getContents <&> (sum . map judge . lines) >>= print where
    judge [a, _, b] = let
        va = ord a - ord 'A'
        vb = (va + s b) `mod` 3 where
            s 'X' = 2
            s 'Y' = 0
            s 'Z' = 1
        in 1 + vb + 3 * fromEnum (va == vb) + 6 * fromEnum ((va + 1) `mod` 3 == vb)

