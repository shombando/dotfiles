#!/usr/bin/sh
set -eu
git remote set-url --push origin --add git@git.sr.ht:~shom/dotfiles
git remote set-url --push origin --add git@github.com:shombando/dotfiles.git
git remote set-url --push origin --add git@codeberg.org:shom/dotfiles.git
