# git-clean-branches

Clean up local branches deleted on a remote

## Usage

Copy the executable file to your `PATH`

### Clean up

```bash
git clean-branches
```

### Fetch upstream branches before clean up

```bash
git clean-branches --fetch-upstream
```

### Show help message

```bash
git clean-branches --help
```

## NOTE

This tool can be implemented using following bash script

```bash
git branch --format '%(refname:short) %(upstream:track)' |\
  grep gone |\
  awk '{print $1}' |\
  xargs -I f git branch -D f
```
