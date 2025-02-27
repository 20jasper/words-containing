{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.List (nub)
import MyLib qualified (someFunc)
import Web.Scotty

main :: IO ()
main = scotty 3001 $ do
  get "/" $ text "hello world"

  get "/:letters" $ do
    letters <- pathParam "letters"
    words <- wordsWith letters <$> liftIO getWords
    json words

getWords :: IO [String]
getWords = do
  lines <$> readFile "top-2500.txt"

wordsWith :: String -> [String] -> [String]
wordsWith xs = filter (all (`elem` xs))
