#!/usr/bin/env bash
set -Eeuo pipefail

import_raycast() {
  echo 'start importing Raycast configuration...'

  open "${HOME}/.config/raycast/raycast.rayconfig"

  echo 'Raycast configuration import completed.'
}

import_raycast
