#!/usr/bin/env bash
set -Eeuo pipefail

install_homebrew() {
  echo 'start installing Homebrew...'

  if command -v brew &>/dev/null; then
    echo "Homebrew is already installed."
    return
  fi

  # Doc: https://brew.sh
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'Homebrew installation completed.'
}

install_homebrew
