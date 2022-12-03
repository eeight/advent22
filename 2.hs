import Data.Functor((<&>))
import Data.Char(ord)

main = getContents <&> (sum . map judge . lines) >>= print where
    judge [a, _, b] = let
        va = ord a - ord 'A'
        vb = ord b - ord 'X'
        in 1 + vb + 3 * fromEnum (va == vb) + 6 * fromEnum ((va + 1) `mod` 3 == vb)

