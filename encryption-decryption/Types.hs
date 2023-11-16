{-# LANGUAGE OverloadedStrings #-}

module Types where

import Crypto.Cipher.AES (AES128)
import Crypto.Cipher.Types (cipherInit, IV, makeIV)
import Crypto.Error (CryptoFailable(..))
import Data.ByteString (ByteString)
import qualified Data.ByteString as B

type Key = ByteString
type Content = ByteString

data Crypto = Crypto {
  key :: Key,
  content :: Content,
  filePath :: Prelude.FilePath
}

initCipher :: Key -> CryptoFailable AES128
initCipher key = cipherInit key

initIV :: Maybe (IV AES128)
initIV = makeIV (B.replicate 16 0 :: ByteString)