-- | This module provides a pure call count plugin that prints a message each
-- time its called. This can be seen in the output of the script
-- @./build-wiring.sh@ that runs each test suite demonstrating a way to wire up
-- plugins that is not expected to fail.  Those test suites with __pure__ in the
-- name use this plugin whereas those with __impure__ in the name use the impure
-- 'CallCount.Impure.Plugin.plugin'.
--
-- @
-- > cat ./build-wiring.sh
-- # The steps in .github/workflows/cabal.yml related to wiring up plugins.
-- # You might like to run cabal update and cabal clean before running this script.
-- cabal build all --disable-tests
-- cabal build test-wireup-pure-by-option
-- cabal build test-wireup-pure-by-pragma
-- cabal build test-wireup-pure-by-both
-- cabal build test-wireup-impure-by-option
-- cabal build test-wireup-impure-by-pragma
-- cabal build test-wireup-impure-by-both
-- cabal build test-counter-main
-- cabal build test-counter-foo-bar-main
-- cabal build test-counter-foobar-main⏎
-- @
--
-- @
-- > ./build-wiring.sh
-- ...
-- Building test suite 'test-wireup-pure-by-option'
-- [1 of 1] Compiling Main
-- >>> GHC-TcPlugin #1
-- ...
-- Building test suite 'test-wireup-pure-by-pragma'
-- [1 of 1] Compiling Main
-- >>> GHC-TcPlugin #1
-- ...
-- Building test suite 'test-wireup-pure-by-both'
-- [1 of 1] Compiling Main
-- >>> GHC-TcPlugin #1
-- >>> GHC-TcPlugin #1
-- ...
-- Building test suite 'test-wireup-impure-by-option'
-- [1 of 1] Compiling Main
-- >>> GHC-TcPlugin #1
-- [1 of 1] Compiling Main [Impure plugin forced recompilation]
-- >>> GHC-TcPlugin #1
-- ...
-- Building test suite 'test-wireup-impure-by-pragma'
-- [1 of 1] Compiling Main
-- >>> GHC-TcPlugin #1
-- [1 of 1] Compiling Main [Impure plugin forced recompilation]
-- >>> GHC-TcPlugin #1
-- ...
-- Building test suite 'test-wireup-impure-by-both'
-- [1 of 1] Compiling Main
-- >>> GHC-TcPlugin #1
-- >>> GHC-TcPlugin #1
-- [1 of 1] Compiling Main [Impure plugin forced recompilation]
-- >>> GHC-TcPlugin #1
-- >>> GHC-TcPlugin #1
-- ...
-- Building test suite 'test-counter-main'
-- [1 of 1] Compiling Main
-- >>> GHC-TcPlugin #1
-- >>> GHC-TcPlugin #2
-- ...
-- Building test suite 'test-counter-foo-bar-main'
-- [1 of 3] Compiling Bar
-- >>> GHC-TcPlugin #1
-- [2 of 3] Compiling Foo
-- >>> GHC-TcPlugin #1
-- [3 of 3] Compiling Main
-- ...
-- Building test suite 'test-counter-foobar-main'
-- [1 of 2] Compiling FooBar
-- >>> GHC-TcPlugin #1
-- >>> GHC-TcPlugin #2
-- [2 of 2] Compiling Main
-- @
module CallCount.Pure.Plugin (plugin) where

import GHC.Corroborate
import NoOp.Plugin (mkPureOptTcPlugin)
import CallCount.TcPlugin (optCallCount)

plugin :: Plugin
plugin = mkPureOptTcPlugin optCallCount
