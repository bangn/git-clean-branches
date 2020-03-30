module GitCleanBranches.Core (
  cleanBranches
) where

import Control.Monad (forM_)
import Data.Maybe (fromMaybe)
import qualified Data.Text as T
import GitCleanBranches.Git (deleteBranch, goneBranches)
import Shellmet ()

cleanBranches :: Bool -> IO ()
cleanBranches fetchUpstream =
  if fetchUpstream
    then do
      putStrLn "Fetching upstream branches"
      "git" ["fetch", "--prune"]
      runClean
    else
      runClean
  where
    runClean :: IO ()
    runClean = do
      gbs <- goneBranches
      case gbs of
        [] -> putStrLn "Nothing to be deleted"
        _  -> do
          putStrLn "Branches to be deleted"
          putStrLn . unwords $ branchesToBeDeleted
          forM_ gbs deleteBranch
            where branchesToBeDeleted = T.unpack . fromMaybe "" <$> gbs
