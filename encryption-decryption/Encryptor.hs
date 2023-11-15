
-- -- Encryptor.hs
-- module Encryptor where

-- import Prelude hiding (FilePath)
-- import Crypto.Hash (Digest, SHA256, hash)
-- import Types (FilePath, Key)

-- encryptFile :: FilePath -> Key -> IO ()
-- encryptFile filePath key = do
--   -- Implement file encryption logic using the provided file path and key
--   putStrLn $ "Encrypting file: " ++ show filePath ++ " with key: " ++ show key

-- decryptFile :: FilePath -> Key -> IO ()
-- decryptFile filePath key = do
--   -- Implement file decryption logic using the provided file path and key
--   putStrLn $ "Decrypting file: " ++ show filePath ++ " with key: " ++ show key


-- Encryptor.hs
module Encryptor
  ( encryptFile
  , decryptFile
  , encryptorLoop
  , CustomFilePath(..)
  , CustomKey(..)
  ) where

import qualified Data.ByteString as BS
import Data.ByteString.Char8 (ByteString,pack)
import Crypto.Cipher.AES (AES128)
import Crypto.Cipher.Types (BlockCipher(..), Cipher, cipherInit, ecbEncrypt, ecbDecrypt)
import Crypto.Error (CryptoError(..), CryptoFailable(..), eitherCryptoError)
import Crypto.Random (getRandomBytes)


-- data CustomFilePath = CustomFilePath FilePath
-- data CustomKey = CustomKey BS.ByteString

newtype CustomFilePath = CustomFilePath FilePath
  deriving (Eq, Show)

newtype CustomKey = CustomKey ByteString
  deriving (Eq, Show)

-- Encryption function using AES128
encryptAES :: CustomKey -> BS.ByteString -> IO BS.ByteString
encryptAES (CustomKey key) plaintext = do
  -- Check if the key length is valid for AES
  when (BS.length key /= 16 && BS.length key /= 24 && BS.length key /= 32) $
    fail "Invalid key length for AES. Key must be 16, 24, or 32 bytes long."

  let cipherResult = cipherInit key :: CryptoFailable AES128
  cipher <- eitherCryptoError cipherResult
  let ciphertext = ecbEncrypt cipher plaintext
  return ciphertext

decryptAES :: CustomKey -> BS.ByteString -> IO BS.ByteString
decryptAES (CustomKey key) ciphertext = do
  -- Check if the key length is valid for AES
  when (BS.length key /= 16 && BS.length key /= 24 && BS.length key /= 32) $
    fail "Invalid key length for AES. Key must be 16, 24, or 32 bytes long."

  let cipherResult = cipherInit key :: CryptoFailable AES128
  cipher <- eitherCryptoError cipherResult
  let plaintext = ecbDecrypt cipher ciphertext
  return plaintext

-- Encrypt a file using AES128
encryptFile :: CustomFilePath -> CustomKey -> IO ()
encryptFile (CustomFilePath filePath) (CustomKey key) = do
  plaintext <- BS.readFile filePath
  ciphertext <- encryptAES (CustomKey key) plaintext
  BS.writeFile (filePath ++ ".enc") ciphertext

-- Decrypt a file using AES128
decryptFile :: CustomFilePath -> CustomKey -> IO ()
decryptFile (CustomFilePath filePath) (CustomKey key) = do
  ciphertext <- BS.readFile filePath
  plaintext <- decryptAES (CustomKey key) ciphertext
  BS.writeFile (filePath ++ ".dec") plaintext

encryptorLoop :: IO ()
encryptorLoop = do
  putStrLn "File Encryption/Decryption Tool"
  putStrLn "1. Encrypt File"
  putStrLn "2. Decrypt File"
  putStrLn "3. Quit"

  putStr "Choose an option: "
  option <- getLine

  case option of
    "1" -> do
      putStr "Enter file path: "
      filePath <- getLine
      putStr "Enter encryption key: "
      key <- getLine
      encryptFile (CustomFilePath filePath) (CustomKey (BS.pack $ map fromIntegral $ map fromEnum key))
      putStrLn "File encrypted successfully."
      encryptorLoop

    "2" -> do
      putStr "Enter encrypted file path: "
      filePath <- getLine
      putStr "Enter decryption key: "
      key <- getLine
      decryptFile (CustomFilePath filePath) (CustomKey (BS.pack $ map fromIntegral $ map fromEnum key))
      putStrLn "File decrypted successfully."
      encryptorLoop

    "3" -> putStrLn "Goodbye!"

    _ -> do
      putStrLn "Invalid option. Please choose again."
      encryptorLoop
