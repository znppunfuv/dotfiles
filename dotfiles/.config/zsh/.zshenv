export LANG=en_US.UTF-8

# The startup files will not be run
# Doc: http://zsh.sourceforge.net/Doc/Release/Options.html#Initialisation
unsetopt GLOBAL_RCS

### PATH ###
typeset -gU PATH path
# Default
typeset -U path_default
path_default=(
    '/usr/local/bin'(N-/)
    '/usr/bin'(N-/)
    '/bin'(N-/)
    '/usr/local/sbin'(N-/)
    '/usr/sbin'(N-/)
    '/sbin'(N-/)
)
path=("${path_default[@]}")
path=(
    # macOS {{{
    '/usr/local/opt/binutils/bin'(N-/)
    '/usr/local/opt/coreutils/libexec/gnubin'(N-/)
    '/usr/local/opt/findutils/libexec/gnubin'(N-/)
    '/usr/local/opt/gnu-sed/libexec/gnubin'(N-/)
    '/usr/local/opt/gnu-tar/libexec/gnubin'(N-/)
    '/usr/local/opt/grep/libexec/gnubin'(N-/)
    '/usr/local/opt/curl/bin'(N-/)
    '/usr/local/opt/openssl@1.1/bin'(N-/)
    '/usr/local/opt/python@3.9/libexec/bin'(N-/)
    '/usr/local/opt/php@7.4/bin'(N-/)
    # }}}
    "${path[@]}"
)

### FPATH ###
fpath=(
    "${ZDOTDIR}/func"(N-/)
    "${ZDOTDIR}/func_comp"(N-/)
    "${fpath[@]}"
)

### MANPATH ###
# macOS
manpath=(
    '/usr/local/opt/coreutils/libexec/gnuman'(N-/)
    '/usr/local/opt/findutils/libexec/gnuman'(N-/)
    '/usr/local/opt/gnu-sed/libexec/gnuman'(N-/)
    '/usr/local/opt/gnu-tar/libexec/gnuman'(N-/)
    '/usr/local/opt/grep/libexec/gnuman'(N-/)
    "${manpath[@]}"
)

### XDG Base Directory ###
# Doc: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_DATA_HOME="${XDG_DATA_HOME:-"${HOME}/.local/share"}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"${HOME}/.config"}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-"${HOME}/.cache"}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-"/tmp/runtime-$(id -u)"}"
if [[ ! -d "${XDG_RUNTIME_DIR}" ]]; then
    command mkdir -m 700 -p -- "${XDG_RUNTIME_DIR}"
fi
