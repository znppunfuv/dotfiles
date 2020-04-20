#!/usr/bin/env sh
set -eu
export LC_ALL=C
export LANG=C
IFS="$(printf " \t\nx")"

XDG_DATA_HOME="${HOME}/.local/share"
GHQ_ROOT="${XDG_DATA_HOME}/ghq"
REPO_ROOT="${GHQ_ROOT}/github.com/znppunfuv/dotfiles"
DOTFILES_HOME="${REPO_ROOT}/dotfiles"

cd "${DOTFILES_HOME}"

echo 'Symlinking dotfiles...'
command find . -type d | command xargs -P 0 -I '{}' command mkdir -p "${HOME}/{}"
command find . -type f |
    command xargs -P 0 -I '{}' command ln -snf "${DOTFILES_HOME}/{}" "${HOME}/{}"
echo 'Symlinking dotfiles complete.'
