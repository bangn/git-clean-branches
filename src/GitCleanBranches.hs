module GitCleanBranches
       ( run
       ) where

import GitCleanBranches.Cli (runCleanBranches)
run :: IO ()
run = runCleanBranches
  -- readProcess "git" ["for-each-ref", "--format", "%(refname:short)%(upstream:track)"] [] >>= print
