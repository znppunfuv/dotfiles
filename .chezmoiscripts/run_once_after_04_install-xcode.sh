#!/usr/bin/env bash
set -Eeuo pipefail

install_xcode() {
  echo 'start installing Xcode...'

  if [ -d "/Applications/Xcode.app" ]; then
    echo "Xcode is already installed."
    return
  fi

  echo "Please sign in to the Mac App Store, then press any key."
  read -r -n 1
  echo

  eval "$(/opt/homebrew/bin/brew shellenv)"
  mas install 497799835

  echo 'Xcode installation completed.'
}

install_xcode