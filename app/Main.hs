module Main where

import Data.List (nub)
import MyLib qualified (someFunc)

main :: IO ()
main = do
  text <- lines <$> readFile "top-2500.txt"
  print $ wordsWith "ailn" text

wordsWith :: String -> [String] -> [String]
wordsWith xs = filter (all (`elem` xs))
