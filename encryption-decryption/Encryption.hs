{-# LANGUAGE OverloadedStrings #-}

module Encryption where

import Crypto.Cipher.AES (AES128)
import Crypto.Cipher.Types (ctrCombine)
import Crypto.Error (CryptoFailable(..))
import Data.ByteString (ByteString)
import qualified Data.ByteString as B
import Types

encrypt :: Crypto -> IO ()
encrypt (Crypto key content filePath) = do
  case initCipher key of
    CryptoPassed cipher -> do
      let iv = maybe (error "Failed to generate IV") id initIV
      let ciphertext = ctrCombine cipher iv content
      B.writeFile (filePath ++ ".enc") ciphertext
      putStrLn "The file has been encrypted."
    CryptoFailed e -> putStrLn $ "Failed to initialize cipher: " ++ show e