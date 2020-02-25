module GitCleanBranches
       ( run
       ) where

import GitCleanBranches.Cli (runCleanBranches)
run :: IO ()
run = runCleanBranches
