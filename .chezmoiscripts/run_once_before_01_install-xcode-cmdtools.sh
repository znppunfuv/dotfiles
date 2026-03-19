#!/usr/bin/env bash
set -Eeuo pipefail

install_command_line_tools() {
  echo 'start installing command line developer tools...'

  if xcode-select -p &>/dev/null; then
    echo "Command line developer tools are already installed."
    return
  fi

  xcode-select --install
  read -r -n 1 -p "Press any key when the installation has completed."
  echo
  echo 'Command line developer tools installation completed.'
}

install_command_line_tools
