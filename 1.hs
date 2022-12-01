import Data.List.Split(splitOn)
import Data.Functor((<&>))

main = getContents <&> (maximum . map (sum . map (read :: String -> Int)) . splitOn [""] . lines) >>= print
