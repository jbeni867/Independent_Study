-- QUESTION 1
-- Write a function that looks up a hash table value that uses the Maybe monad. Write a hash that stores other hashes, several levels deep. Use the Maybe monad to retrieve an element for a hash key several levels deep.
myLookup :: String -> [(String, a)] -> Maybe a
myLookup key [] = Nothing
myLookup key ((k, v) : xs) = if key == k 
                             then Just v 
                             else myLookup key xs

-- Example data:
-- user_settings -> interface -> theme -> "dark"
myNestedHash :: [(String, [(String, [(String, String)])])]
myNestedHash = 
  [ ("user_settings", 
      [ ("interface", 
          [ ("theme", "dark")
          , ("font", "Monospace")
          ]
        )
      ]
    )
  ]

lookupDeep :: String -> String -> String -> Maybe String
lookupDeep k1 k2 k3 = do
  level1 <- myLookup k1 myNestedHash
  level2 <- myLookup k2 level1
  level3 <- myLookup k3 level2
  return level3

-- lookupDeep "user_settings" "interface" "theme"

-- QUESTION 2
-- Represent a maze in Haskell. You’ll need a Maze type and a Node type, as well as a function to return a node given its coordinates. The node should have a list of exits to other nodes.
type Coord = (Int, Int)

data Node = Node Coord [Coord]
  deriving (Show, Eq)

type Maze = [Node]

getNode :: Coord -> Maze -> Maybe Node
getNode target [] = Nothing
getNode target (Node c exits : ns) = if target == c 
                                     then Just (Node c exits) 
                                     else getNode target ns

exampleMaze :: Maze
exampleMaze = 
  [ Node (0,0) [(0,1), (1,0)]
  , Node (0,1) [(0,0), (1,1)]
  , Node (1,0) [(0,0)]
  , Node (1,1) [(0,1)]
  ]

-- QUESTION 3
-- Use a List monad to solve the maze.
solve :: Coord -> Coord -> [Coord] -> Maze -> [[Coord]]
solve current goal visited maze = do
  if current == goal
    then return (visited ++ [current])
    else do
      Node _ exits <- case getNode current maze of
                        Just n  -> [n]
                        Nothing -> []
      
      next <- exits
      
      if next `elem` visited
        then []
        else solve next goal (visited ++ [current]) maze

-- solve (0,0) (1,1) [] exampleMaze

-- QUESTION 4
-- Implement a Monad in a nonfunctional language. (I chose c# since I am pretty familliar with it)
public class Maybe<T>
{
    public T Value { get; }
    public bool HasValue { get; }

    // Private constructor so you have to use the helper methods
    private Maybe(T value, bool hasValue)
    {
        Value = value;
        HasValue = hasValue;
    }

    // "Return" / "Just" operation
    public static Maybe<T> Just(T value) => new Maybe<T>(value, true);

    // "Nothing" operation
    public static Maybe<T> Nothing() => new Maybe<T>(default, false);

    // The "Bind" method (equivalent to Haskell's >>=)
    public Maybe<U> Bind<U>(Func<T, Maybe<U>> func)
    {
        if (!HasValue)
        {
            return Maybe<U>.Nothing();
        }
        return func(Value);
    }
}