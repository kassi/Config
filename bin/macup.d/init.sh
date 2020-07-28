#!/bin/zsh
set -e

destination=${1:-System/Config}
if [[ -d $destination ]]; then
  if [[ -d $destination/.git ]]; then
    echo "Destination already contains a git repository. Aborting"
    exit 1
  else
    destination=$destination/Config
  fi
fi

# Command Line Developer Tools are needed for git to clone…
echo "Installing Xcode Command Line Tools."
while [[ $((xcode-select --install) 2>&1) =~ "xcode-select: note: " ]]; do
  while [[ -n $(ps ax | grep "Install Command Line Developer Tools.app" | grep -v grep) ]]
  do
    sleep 10
  done
done

echo "Cloning into $destination."
git clone --bare git@github.com:kassi/Config $destination

function config {
  /usr/bin/git --git-dir=$destination --work-tree=$HOME "$@"
}

mkdir -p .config-backup
config checkout
if [ $? != 0 ]; then
  echo "Backing up pre-existing dot files."
  config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi
config checkout
config config status.showUntrackedFiles no
