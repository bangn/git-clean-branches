module GitCleanBranches.Git.Branch ( allBranches
                                   , deleteBranch
                                   , goneBranches
) where

import qualified Data.Text as T
import Shellmet ()
import System.Process

deleteBranch :: Maybe T.Text -> IO ()
deleteBranch Nothing       = return ()
deleteBranch (Just branch) = "git" ["branch", "-D", branch]

goneBranches :: IO [Maybe T.Text]
goneBranches =
  let gone :: T.Text
      gone = "[gone]"
  in
    do
      branches <- allBranches
      return $ fmap (T.stripSuffix gone) (filter (T.isSuffixOf gone) $ T.pack <$> branches)

allBranches :: IO [String]
allBranches = do
  branches <- readProcess "git" ["branch", "--format", "%(refname:short)%(upstream:track)"] []
  return $ wordsWhen (== '\n') branches
    where
      wordsWhen :: (Char -> Bool) -> String -> [String]
      wordsWhen p s =
        case dropWhile p s of
          "" -> []
          s' -> w : wordsWhen p s''
                where (w, s'') = break p s'
