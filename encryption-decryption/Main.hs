{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.ByteString (ByteString)
import qualified Data.ByteString as B
import qualified Data.ByteString.Char8 as C
import System.IO
import Types
import Encryption
import Decryption

main :: IO ()
main = do
  putStrLn "Choose an option:"
  putStrLn "1. Encrypt a file"
  putStrLn "2. Decrypt a file"
  putStrLn "3. Exit"
  option <- getLine
  case option of
    "1" -> do
      putStrLn "Enter the file path:"
      filePath <- getLine
      putStrLn "Enter the secret key (16 characters):"
      key <- getLine
      content <- B.readFile filePath
      encrypt (Crypto (C.pack key) content filePath)
    "2" -> do
      putStrLn "Enter the encrypted file path:"
      filePath <- getLine
      putStrLn "Enter the secret key (16 characters):"
      key <- getLine
      content <- B.readFile filePath
      decrypt (Crypto (C.pack key) content filePath)
    "3" -> return ()
    _ -> putStrLn "Invalid option."