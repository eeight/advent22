import Control.Monad.State.Strict
import Data.Char

data T = Atom Int | List [T] deriving (Show)

type P = State String

main = (solve <$> getContents) >>= print where
    solve = sum . map toIndex . zip [1..] . readInput  . lines

    toIndex (i, (x, y)) | cmp x y == LT = i
    toIndex _ = 0

    readInput (x:y:xs) = (evalState parse x, evalState parse y):readInput (drop 1 xs)
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

    cmp (Atom x) (Atom y) = compare x y
    cmp (Atom x) (List y) = cmp (List [Atom x]) (List y)
    cmp (List x) (Atom y) = cmp (List x) (List [Atom y])
    cmp (List []) (List []) = EQ
    cmp (List []) (List (_:_)) = LT
    cmp (List (_:_)) (List []) = GT
    cmp (List (x:xs)) (List (y:ys)) = cmp x y `mappend` cmp (List xs) (List ys)
