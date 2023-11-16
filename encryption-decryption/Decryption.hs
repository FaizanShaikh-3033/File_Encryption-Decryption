{-# LANGUAGE OverloadedStrings #-}

module Decryption where

import Crypto.Cipher.AES (AES128)
import Crypto.Cipher.Types (ctrCombine)
import Crypto.Error (CryptoFailable(..))
import Data.ByteString (ByteString)
import qualified Data.ByteString as B
import Types

decrypt :: Crypto -> IO ()
decrypt (Crypto key content filePath) = do
  case initCipher key of
    CryptoPassed cipher -> do
      let iv = maybe (error "Failed to generate IV") id initIV
      let decrypted = ctrCombine cipher iv content
      B.writeFile (filePath ++ ".dec") decrypted
      putStrLn "The file has been decrypted."
    CryptoFailed e -> putStrLn $ "Failed to initialize cipher: " ++ show e