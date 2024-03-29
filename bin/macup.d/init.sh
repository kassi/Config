#!/bin/bash
set -e

destination=${1:-$HOME/System/Config}
if [[ -d $destination ]]; then
  if [[ -d $destination/refs ]]; then
    echo "Destination already contains a bare git repository. Aborting"
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

# Need a valid ssh key
if [[ ! -e $HOME/.ssh/id_rsa ]]; then
  echo "No ssh key found."
  read -p "Press ENTER to create a new one or CTRL-C to cancel and copy an existing one in place" < /dev/tty
  ssh-keygen -b 4096
  cat $HOME/.ssh/id_rsa.pub | pbcopy
  echo "Now create a new key in Github and paste the copied public key"
  open "https://github.com/settings/ssh/new"
  read -p "Press ENTER when done" < /dev/tty
fi

echo "Cloning into $destination."
git clone --bare git@github.com:kassi/Config $destination

function config {
  /usr/bin/git --git-dir=$destination --work-tree=$HOME "$@"
}

mkdir -p .config-backup
set +e
config checkout 2>/dev/null
if [ $? != 0 ]; then
  echo "Backing up pre-existing dot files."
  config checkout 2>&1 | egrep "^\s+" | awk {'print $1'} | xargs tar cf .config-backup/$(date +"%Y-%m-%d-%H:%M:%S").tar
  config checkout 2>&1 | egrep "^\s+" | awk {'print $1'} | xargs rm -rf
fi
set -e
config checkout
config config status.showUntrackedFiles no

echo "Checkout finished. Your dotfiles are now in place."
echo "Now run 'bin/macup' to install apps."
