{-# LANGUAGE OverloadedStrings #-}

import qualified Data.ByteString.Lazy.Char8   as C
import qualified Data.Vector.Algorithms.Intro as Alg
import qualified Data.Vector.Unboxed          as U

sort :: (Ord a, U.Unbox a) => [a] -> [a]
sort = U.toList . U.modify Alg.sort . U.fromList

main :: IO ()
main = C.readFile "random_numbers"
   >>= maybe (print "Failed to parse!")
             ( C.writeFile "haskell_result"
             . C.intercalate "," . fmap (C.pack . show) . sort . fmap fst
             ) . traverse C.readInt . C.split ','
