-- Types.hs
module Types (CustomFilePath(..), CustomKey(..), pack) where

import Data.ByteString (ByteString, pack)

data CustomFilePath = CustomFilePath FilePath
  deriving (Show)

data CustomKey = CustomKey ByteString
  deriving (Show)
