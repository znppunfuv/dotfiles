#!/usr/bin/env sh
set -eu
export LC_ALL=C
export LANG=C
IFS="$(printf " \t\nx")"

XDG_DATA_HOME="${HOME}/.local/share"
XDG_CONFIG_HOME="${HOME}/.config"
ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
ZSH_FUNCCOMP_DIR="${ZDOTDIR}/func_comp"
GHQ_ROOT="${XDG_DATA_HOME}/ghq"
REPO_ROOT="${GHQ_ROOT}/github.com/znppunfuv/dotfiles"
DOTFILES_HOME="${REPO_ROOT}/dotfiles"

command mkdir -p "${ZSH_FUNCCOMP_DIR}"

### macOS ###
if [ "$(uname)" = 'Darwin' ]; then
    # Homebrew
    echo 'Install Homebrew...'
    if type brew >/dev/null 2>&1; then
        echo 'Homebrew is already installed. Skipped this step.'
    else
        /bin/bash -c "$(
            command curl --proto '=https' --tlsv1.2 -sSfL \
                https://raw.githubusercontent.com/Homebrew/install/master/install.sh
        )"
        echo 'Install Homebrew complete.'
    fi
    echo 'Install Homebrew apps...'
    brew bundle install --file "${DOTFILES_HOME}/.config/homebrew/Brewfile" --no-lock
fi

### asdf-vm ###
echo 'Install asdf-vm'
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"
if type asdf >/dev/null 2>&1 && [ -d "${ASDF_DATA_DIR}" ]; then
    echo 'asdf-vm is already installed. Skipped this step.'
else
    command git clone https://github.com/asdf-vm/asdf.git "${ASDF_DATA_DIR}" --branch v0.7.8
    # shellcheck disable=SC1090
    . "${ASDF_DATA_DIR}/asdf.sh"
    export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc"
    asdf plugin add direnv
    asdf plugin add nodejs
    /bin/bash "${ASDF_DATA_DIR}/plugins/nodejs/bin/import-release-team-keyring"
    asdf install
fi

### Rust ###
echo 'Install Rust'
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
if type rustup >/dev/null 2>&1 && [ -d "${RUSTUP_HOME}" ] && [ -d "${CARGO_HOME}" ]; then
    echo 'rustup is already installed. Skipped this step.'
else
    command curl --proto '=https' --tlsv1.2 -sSf \
        https://sh.rustup.rs | sh -s -- -y --no-modify-path
    # shellcheck disable=SC1090
    . "${CARGO_HOME}/env"
    rustup completions zsh >"${ZSH_FUNCCOMP_DIR}/_rustup"
    ln -snf "$(rustc --print sysroot)/share/zsh/site-functions/_cargo" \
        "${ZSH_FUNCCOMP_DIR}/_cargo"
    # For rust-analyzer
    # Doc: https://rust-analyzer.github.io/manual.html#installation
    rustup component add rust-src
fi

### Python ###
echo 'Install Poetry'
export POETRY_HOME="${XDG_DATA_HOME}/poetry"
if type poetry >/dev/null 2>&1 && [ -d "${POETRY_HOME}" ]; then
    echo 'Poetry is already installed. Skipped this step.'
else
    command curl --proto '=https' --tlsv1.2 -sSf \
        https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py |
        python
    # shellcheck disable=SC1090
    . "${XDG_DATA_HOME}/poetry/env"
    poetry completions zsh >"${ZSH_FUNCCOMP_DIR}/_poetry"
    poetry config virtualenvs.in-project true
fi

### Neovim ###
echo 'Install Neovim'
cd "${XDG_CONFIG_HOME}/nvim/python"
poetry install
