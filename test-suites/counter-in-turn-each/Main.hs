{-# OPTIONS_GHC     -fplugin CallCount.Pure.Plugin1 #-}
{-# OPTIONS_GHC -fplugin-opt CallCount.Pure.Plugin1:A #-}
{-# OPTIONS_GHC     -fplugin CallCount.Pure.Plugin2 #-}
{-# OPTIONS_GHC -fplugin-opt CallCount.Pure.Plugin2:B #-}

module Main where

foo :: IO a
foo = undefined

bar :: IO a
bar = undefined

main :: IO ()
main = return ()
