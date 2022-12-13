import Control.Monad.State.Strict
import Data.Char
import Data.List

data T = Atom Int | List [T] deriving (Show)

instance Ord T where
    compare (Atom x) (Atom y) = compare x y
    compare (Atom x) (List y) = compare (List [Atom x]) (List y)
    compare (List x) (Atom y) = compare (List x) (List [Atom y])
    compare (List []) (List []) = EQ
    compare (List []) (List (_:_)) = LT
    compare (List (_:_)) (List []) = GT
    compare (List (x:xs)) (List (y:ys)) = compare x y `mappend` compare (List xs) (List ys)

instance Eq T where
    x == y = compare x y == EQ

type P = State String

d1 = List [List [Atom 2]]
d2 = List [List [Atom 6]]

main = (solve <$> getContents) >>= print where
    solve input = let
        xs = readInput . lines $ input
        xs' = sort $ [d1, d2] ++ xs
        in product . map fst . filter ((`elem` [d1, d2]) . snd) . zip [1..] $ xs'

    readInput (x:xs) | not (null x) = evalState parse x:readInput xs
    readInput (_:xs) = readInput xs
    readInput _ = []

    match :: Char -> P Bool
    match c = do
        c' <- peek
        if c' == c
            then modify' tail >> return True
            else return False

    peek :: P Char
    peek = gets head

    parseInt :: P Int
    parseInt = do
        x <- gets $ takeWhile isDigit
        modify' $ dropWhile isDigit
        return $ read x

    parseList :: P [T]
    parseList = do
        isEmpty <- match ']'
        if isEmpty
            then return []
            else do
                x <- parse
                b <- match ','
                if b
                    then do (x:) `fmap` parseList
                    else match ']' >> return [x]

    parse :: P T
    parse = do
        isList <- match '['
        if isList
            then List <$> parseList
            else Atom <$> parseInt

