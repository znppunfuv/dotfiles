#!/usr/bin/env bash
set -Eeuo pipefail

setup_ssh_key() {
  echo 'start setting up SSH key...'

  if [ -e "${HOME}/.ssh/id_ed25519_sk_rk" ]; then
    echo "SSH key already exists."
    return
  fi

  while ! ykman list 2>/dev/null | grep -q "YubiKey"; do
    echo "YubiKey is not connected. Please insert YubiKey and wait..."
    sleep 2
  done

  cd "$HOME/.ssh"
  ssh-keygen -K

  echo 'SSH key setup completed.'
}

setup_ssh_key
