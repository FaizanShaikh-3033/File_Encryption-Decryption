-- -- Main.hs
-- module Main where

-- import System.IO
-- import Encryptor (encryptFile, decryptFile, encryptorLoop, CustomFilePath(..), CustomKey(..))
-- import qualified Encryptor (encryptorLoop)
-- import Types (pack)

-- main :: IO ()
-- main = do
--   hSetBuffering stdout NoBuffering
--   Encryptor.encryptorLoop

-- encryptorLoop :: IO ()
-- encryptorLoop = do
--   putStrLn "File Encryption/Decryption Tool"
--   putStrLn "1. Encrypt File"
--   putStrLn "2. Decrypt File"
--   putStrLn "3. Quit"

--   putStr "Choose an option: "
--   option <- getLine

--   case option of
--     "1" -> do
--       putStr "Enter file path: "
--       filePath <- getLine
--       putStr "Enter encryption key: "
--       key <- getLine
--       encryptFile (CustomFilePath filePath) (CustomKey (pack key))
--       putStrLn "File encrypted successfully."
--       encryptorLoop

--     "2" -> do
--       putStr "Enter encrypted file path: "
--       filePath <- getLine
--       putStr "Enter decryption key: "
--       key <- getLine
--       decryptFile (CustomFilePath filePath) (CustomKey (pack key))
--       putStrLn "File decrypted successfully."
--       encryptorLoop

--     "3" -> putStrLn "Goodbye!"

--     _ -> do
--       putStrLn "Invalid option. Please choose again."
--       encryptorLoop



-- Main.hs
module Main where

import System.IO
import Encryptor (encryptFile, decryptFile, CustomFilePath(..), CustomKey(..))
import qualified Encryptor as E
import Types (pack)

main :: IO ()
main = do
  hSetBuffering stdout NoBuffering
  E.encryptorLoop
