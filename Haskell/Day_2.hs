-- QUESTION 1
-- Write a sort that takes a list and returns a sorted list.
insert :: Int -> [Int] -> [Int]
insert x [] = [x]
insert x (y:ys) = if x <= y 
                  then x : y : ys 
                  else y : insert x ys

mySort :: [Int] -> [Int]
mySort [] = []
mySort (x:xs) = insert x (mySort xs)

-- QUESTION 2
-- Write a sort that takes a list and a function that compares its two arguments and then returns a sorted list.
insertBy :: (a -> a -> Bool) -> a -> [a] -> [a]
insertBy comp x [] = [x]
insertBy comp x (y:ys) = if comp x y 
                         then x : y : ys 
                         else y : insertBy comp x ys

mySortBy :: (a -> a -> Bool) -> [a] -> [a]
mySortBy comp [] = []
mySortBy comp (x:xs) = insertBy comp x (mySortBy comp xs)
-- mySortBy (<) [4, 1, 3, 2]

-- QUESTION 3
-- Write a Haskell function to convert a string to a number. The string should be in the form of $2,345,678.99 and can possibly have leading zeros.
parseCurrency :: String -> Double
parseCurrency str = read cleanStr
  where
    cleanStr = [c | c <- str, c /= '$', c /= ',']

-- QUESTION 4
-- Write a function that takes an argument x and returns a lazy sequence that has every third number, starting with x. Then, write a function that includes every fifth number, beginning with y. Combine these functions through composition to return every eighth number, beginning with x + y.
everyThird :: Int -> [Int]
everyThird x = [x, x+3 ..]

everyFifth :: Int -> [Int]
everyFifth y = [y, y+5 ..]

everyEighth :: Int -> Int -> [Int]
everyEighth x y = [x+y, (x+y)+8 ..]

-- QUESTION 5
-- Use a partially applied function to define a function that will return half of a number and another that will append \n to the end of any string. 
half :: Double -> Double
half = (/ 2)

appendNewline :: String -> String
appendNewline = flip (++) "\n"