module GitCleanBranches.Core (
  cleanBranches
) where

import Control.Monad (forM_)
import GitCleanBranches.Git (allBranches, deleteBranch, goneBranches)
import Shellmet ()

cleanBranches :: Bool -> IO ()
cleanBranches fetchUpstream = do
  bs <- allBranches
  putStrLn "All branches: "
  putStrLn $ unlines bs
  if fetchUpstream
  then do
     putStrLn "Fetching upstream branches"
     "git" ["fetch", "--prune"]
     gbs <- goneBranches
     forM_ gbs deleteBranch
  else do
     gbs <- goneBranches
     forM_ gbs deleteBranch
