import Data.List.Split(splitOn)
import Data.Functor((<&>))
import Data.List(sort)

main = getContents <&> (sum . take 3 . reverse . sort . map (sum . map (read :: String -> Int)) . splitOn [""] . lines) >>= print
