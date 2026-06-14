-- QUESTION 1
-- How many different ways can you find to write allEven?
allEven1 :: [Int] -> Bool
allEven1 xs = all even xs

allEven2 :: [Int] -> Bool
allEven2 xs = length (filter even xs) == length xs

-- QUESTION 2
-- Write a function that takes a list and returns the same list in reverse.
myReverseRec :: [a] -> [a]
myReverseRec []     = []
myReverseRec (x:xs) = myReverseRec xs ++ [x]

-- QUESTION 3
-- Write a function that builds two-tuples with all possible combinations of two of the colors black, white, blue, yellow, and red. Note that you should include only one of (black, blue) and (blue, black).
colorCombinations :: [(String, String)]
colorCombinations = [(c1, c2) | c1 <- colors, c2 <- colors, c1 < c2]
  where
    colors = ["black", "white", "blue", "yellow", "red"]

-- QUESTION 4
-- Write a list comprehension to build a childhood multiplication table. The table would be a list of three-tuples where the first two are integers from 1--12 and the third is the product of the first two.
multiplicationTable :: [(Int, Int, Int)]
multiplicationTable = [(x, y, x * y) | x <- [1..12], y <- [1..12]]

-- QUESTION 5
-- Solve the map-coloring problem (​Map Coloring​) using Haskell.
colors :: [String]
colors = ["Red", "Green", "Blue"]

solveMapColoring :: [(String, String, String, String, String)]
solveMapColoring = [ (a, b, c, d, e) 
                   | a <- colors, b <- colors, c <- colors, d <- colors, e <- colors
                   , a /= b 
                   , a /= c 
                   , b /= c 
                   , b /= d 
                   , c /= d 
                   , d /= e ]