module GitCleanBranches
       ( run
       ) where

import GitCleanBranches.Cli (runCleanBranches)
run :: IO ()
run = do
  putStrLn "Start cleaning..."
  runCleanBranches
