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
    ## Appearance: dark
    # defaults delete .GlobalPreferences AppleInterfaceStyleSwitchesAutomatically
    # defaults write .GlobalPreferences AppleInterfaceStyle -string "Dark"
    ## Accent color: yellow
    # defaults write .GlobalPreferences AppleAccentColor -int 2
    ## Highlight color: yellow
    # defaults write .GlobalPreferences AppleHighlightColor -string "1.000000 0.937255 0.690196 Yellow"
    ## Show scroll bars
    # defaults write .GlobalPreferences AppleShowScrollBars -string "Always"
    # defaults write .GlobalPreferences AppleScrollerPagingBehavior -bool true
    ## Dock
    defaults delete com.apple.dock orientation
    defaults write com.apple.dock tilesize -int 40
    defaults write com.apple.dock autohide -bool false
    defaults write com.apple.dock magnification -bool false
    defaults write com.apple.dock show-recents -bool false
    defaults write com.apple.dock mineffect -string "scale"
    ## Siri
    defaults write com.apple.assistant.support.plist "Assistant Enabled" -bool false
    defaults write com.apple.Siri StatusMenuVisible -bool false
    # Handsoff
    defaults -currentHost write com.apple.coreservices.useractivityd.plist ActivityReceivingAllowed -bool true
    defaults -currentHost write com.apple.coreservices.useractivityd.plist ActivityAdvertisingAllowed -bool true
    # Font smoothing
    # defaults -currentHost delete .GlobalPreferences AppleFontSmoothing

    ## Finder
    chflags nohidden ~/Library
    defaults write com.apple.finder AppleShowAllFiles -bool true
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
    defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
    defaults write -g AppleShowAllExtensions -bool true
    killall Finder

    killall Dock
    # Menubar
    defaults write com.apple.menuextra.battery ShowPercent -bool true
    defaults write com.apple.menuextra.clock DateFormat -string "EEE MMM d HH:mm:ss"
    killall SystemUIServer

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
    chmod 755 /usr/local/share/zsh
    chmod 755 /usr/local/share/zsh/site-functions
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
cd "${XDG_DATA_HOME}/nvim/python"
poetry install
