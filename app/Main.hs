{-# LANGUAGE OverloadedStrings #-}

module Main where

import Control.Monad.IO.Class (MonadIO (liftIO))
import Web.Scotty (get, json, pathParam, scotty, text)

main :: IO ()
main = scotty 3001 $ do
  get "/" $ text "hello world"

  get "/all/:letters" $ do
    letters <- pathParam "letters"
    words <- wordsWithAll letters <$> liftIO getWords
    json words

  get "/any/:letters" $ do
    letters <- pathParam "letters"
    words <- wordsWithAny letters <$> liftIO getWords
    json words

getWords :: IO [String]
getWords = do
  lines <$> readFile "top-2500.txt"

wordsWithAll :: String -> [String] -> [String]
wordsWithAll xs = filter (all (`elem` xs))

wordsWithAny :: String -> [String] -> [String]
wordsWithAny xs = filter (any (`elem` xs))
