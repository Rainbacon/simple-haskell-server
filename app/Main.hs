{-# LANGUAGE OverloadedStrings #-}
module Main where

import Network.Wai
import Network.Wai.Handler.Warp
import Network.HTTP.Types
import Blaze.ByteString.Builder
import qualified Data.ByteString.UTF8 as BU
import Data.Monoid

main :: IO ()
main = do
       let port = 8080
       putStrLn $ "Listening on port " ++ show port
       run port app

app req respond = respond $ case pathInfo req of
                                 ["home"] -> home
                                 x -> index x

home = responseBuilder status200 [("Content-Type", "text/plain")] $ mconcat $ map copyByteString ["Welcome to the Simple Haskell Web Server!"]

index x = responseBuilder status200 [("Content-Type", "text/html")] $ mconcat $ map copyByteString ["<p>Hello from ", BU.fromString $ show x, "!</p>", "<p><a href='/home'>home</a></p>\n"]
