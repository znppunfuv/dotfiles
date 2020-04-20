#!/usr/bin/env sh
set -eu
export LC_ALL=C
export LANG=C
IFS="$(printf " \t\nx")"

REPO_URI='https://github.com/znppunfuv/dotfiles'
XDG_DATA_HOME="${HOME}/.local/share"
GHQ_ROOT="${XDG_DATA_HOME}/ghq"
REPO_ROOT="${GHQ_ROOT}/github.com/znppunfuv/dotfiles"

if [ ! -d "${REPO_ROOT}" ]; then
    command git clone "${REPO_URI}" "${REPO_ROOT}"
else
    cd "${REPO_ROOT}"
    command git pull origin master
fi

cd "${REPO_ROOT}"
sh ./src/link.sh
sh ./src/install.sh
