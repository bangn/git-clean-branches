module GitCleanBranches.Cli (
  runCleanBranches
) where

import Data.Version (showVersion)
import GitCleanBranches.Core (cleanBranches)
import Options.Applicative (Parser, ParserInfo, execParser, fullDesc, help,
                            helper, info, infoOption, long, progDesc, short,
                            switch)
import Paths_git_clean_branches as Meta (version)

runCleanBranches :: IO ()
runCleanBranches = execParser cliParser >>= \case
  CliOptions fetchUpstream -> cleanBranches fetchUpstream

cliParser :: ParserInfo CliOptions
cliParser = info
  (helper <*> versionP <*> cliOptionsP)
    $ fullDesc <> progDesc "Clean up local branches deleted on a remote"

newtype CliOptions = CliOptions { fetchUpstream :: Bool }

--------------------------------------------------------------------------------
-- Parsers
--------------------------------------------------------------------------------

versionP :: Parser (a -> a)
versionP = infoOption cliVersion $
    long "version" <> short 'v' <> help "Show version"

cliVersion :: String
cliVersion = showVersion Meta.version

cliOptionsP :: Parser CliOptions
cliOptionsP = CliOptions
    <$> switch
         (long "fetch-upstream"
         <> short 'f'
         <> help "Fetch upstream branch")
