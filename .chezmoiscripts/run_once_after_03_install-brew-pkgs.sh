#!/usr/bin/env bash
set -Eeuo pipefail

install_brew_packages() {
  echo 'start installing Homebrew packages...'

  eval "$(/opt/homebrew/bin/brew shellenv)"
  brew bundle --file="${HOME}/.Brewfile"

  echo 'Homebrew packages installation completed.'
}

install_brew_packages
