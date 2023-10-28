#!/usr/bin/env sh
#
# This script assumes that the dotfiles repository will be initially cloned as
# a non-bare repository. It will then be converted to a bare repository with
# the working directory set to $HOME. Alternatively, the repository can be
# cloned as a bare repository to $HOME/.dotfiles, and this script can be
# ignored.

set errexit  # Exit on error.
set nounset  # Error on undeclared variables.
set pipefail # Error if any command in a pipe fails.

REPO_URL=git@github.com:murar8/dotfiles.git
REPO_DIR=$HOME/.dotfiles
SCRIPT_DIR=$( cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P )

echo "Setup started"
echo "Repository:       $REPO_URL"
echo "Target directory: $REPO_DIR"
echo

dot() {
	git --git-dir=$REPO_DIR/ --work-tree=$HOME $@
}

cd $HOME

if ! command -v git >/dev/null; then
	echo "Error: could not locate git in your path."
	exit 1
fi

if [ ! -d $REPO_DIR ]; then
	git clone --bare $SCRIPT_DIR $REPO_DIR
	dot config status.showUntrackedFiles no
	dot remote set-url origin $REPO_URL
	echo "Cloned repository to $REPO_DIR, deleting $SCRIPT_DIR"
	rm -rf $SCRIPT_DIR
	echo
fi

STASH_NAME="dotfiles-backup-$(date +%F)"
echo "Stashing potential conflicts in $STASH_NAME"
dot -c user.name=$USER -c user.email=$USER@localhost stash save $STASH_NAME
