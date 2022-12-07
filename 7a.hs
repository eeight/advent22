import Data.List(intercalate)
import qualified Data.Map as M

data Tree = Tree { treeDirs :: M.Map String Tree, treeFiles :: M.Map String Int } deriving (Show)

emptyTree = Tree M.empty M.empty

overDirs (Tree dirs files) f = Tree (f dirs) files
overFiles (Tree dirs files) f = Tree dirs (f files)

data Zipper = Zipper { unzip :: [(String, Tree)] } deriving (Show)

open :: Tree -> Zipper
open tree = Zipper [("", tree)]

enter :: String -> Zipper -> Zipper
enter name (Zipper ((parent, tree):ts)) = Zipper $ (name, subtree):(parent, tree'):ts where
    subtree = M.findWithDefault emptyTree name (treeDirs tree)
    tree' = overDirs tree $ M.delete name

leave :: Zipper -> Zipper
leave (Zipper ((name, subtree):(parent, tree):ts)) = Zipper $ (parent, tree'):ts where
    tree' = overDirs tree $ M.insert name subtree

addFile :: Zipper -> String -> Int -> Zipper
addFile (Zipper ((dirname, tree):ts)) filename size = Zipper $ (dirname, overFiles tree $ M.insert filename size):ts

close :: Zipper -> Tree
close (Zipper [(_, tree)]) = tree
close z = close $ leave z

main = (solve <$> getContents) >>= print where
    solve input = let
        sizes = dirSizes . parse (open emptyTree) . lines $ input
        neededSpace =  head sizes - 40000000
        in minimum . filter (>= neededSpace) $ sizes

    parse :: Zipper -> [String] -> Tree
    parse zipper [] = close zipper
    parse zipper (l:ls) =
        let f:s:r = words l
        in case (f, s) of
            ("$", "cd") -> parse (cd (head r) zipper) ls
            ("$", "ls") -> parse zipper ls
            ("dir", _) -> parse zipper ls
            otherwise -> parse (addFile zipper s (read f)) ls

    cd "/"  = id
    cd ".." = leave
    cd name = enter name

    dirSizes (Tree dirs files) = let
        subdirSizes = map (dirSizes . snd) . M.toList $ dirs
        filesSize = sum . map snd . M.toList $ files
        thisSize = filesSize + (sum $ map head subdirSizes)
        in thisSize:concat subdirSizes
