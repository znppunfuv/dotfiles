### Zinit ###
# Repo: https://github.com/zdharma/zinit
declare -A ZINIT
ZINIT[HOME_DIR]="${XDG_DATA_HOME}/zsh/plugin/zinit"

# Auto install
if [[ ! -f "${ZINIT[HOME_DIR]}/bin/zinit.zsh" ]]; then
    echo 'Install Zinit'
    command git clone 'https://github.com/zdharma/zinit' "${ZINIT[HOME_DIR]}/bin"
    . "${ZINIT[HOME_DIR]}/bin/zinit.zsh"
    zinit self-update
fi

. "${ZINIT[HOME_DIR]}/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

alias zinit-update='zinit update --all && zinit self-update && zinit compile --all'

### Plugins ###
zinit ice wait=1 lucid \
    atclone='dircolors -b dircolors.256dark > color.zsh' \
    atpull='%atclone' \
    pick='color.zsh' \
    nocompile='!' \
    atload='zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"'
zinit light seebi/dircolors-solarized

zinit ice wait=0 lucid \
    atclone='
        . ./fast-syntax-highlighting.plugin.zsh
        fast-theme -q XDG:solarized-dark
    ' \
    atinit='zicompinit; zicdreplay'
zinit light zdharma/fast-syntax-highlighting

zinit ice wait=0 lucid \
    pick='zsh-history-substring-search.zsh' \
    atload="
        bindkey '^[[A' history-substring-search-up
        bindkey '^[[B' history-substring-search-down
        bindkey -M vicmd 'k' history-substring-search-up
        bindkey -M vicmd 'j' history-substring-search-down
    "
zinit light zsh-users/zsh-history-substring-search

zinit ice wait=0 lucid \
    atload="
        _zsh_autosuggest_start
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'
    "
zinit light zsh-users/zsh-autosuggestions

zinit ice wait=0 blockf lucid
zinit light zsh-users/zsh-completions

zinit ice wait=0 lucid
zinit light hlissner/zsh-autopair

zinit ice \
    as='program' \
    from='gh-r' \
    ver='latest' \
    mv='powerline-go* -> powerline-go' \
    pick='powerline-go'
zinit light justjanne/powerline-go
powerline_precmd() {
    PS1="$( \
        "${ZINIT[HOME_DIR]}/plugins/justjanne---powerline-go/powerline-go" \
        -error "$?" \
        -shell zsh \
        -newline \
        -priority 'root,user,ssh,perms,git-branch,git-status,exit,cwd-path' \
        -path-aliases '~/.local/share/ghq=@ghq'
    )"
}
install_powerline_precmd() {
    local func
    for func in "${precmd_functions[@]}"; do
        if [[ "${func}" == 'powerline_precmd' ]]; then
            return 0
        fi
    done
    precmd_functions+=('powerline_precmd')
}
install_powerline_precmd

zinit ice wait=0 lucid \
    atload="
        bindkey '^G' anyframe-widget-cd-ghq-repository
        alias fcdr='anyframe-widget-cdr'
        alias fh='anyframe-widget-put-history'
        alias fkill='anyframe-widget-kill'
    "
zinit light mollifier/anyframe

zinit ice wait=0 lucid \
    atinit='export FORGIT_GI_REPO_LOCAL="${XDG_DATA_HOME}/zsh/plugin/forgit"' \
    atclone='
        . ./forgit.plugin.zsh
        forgit::ignore::update
        git_config_dir="${XDG_CONFIG_HOME}/git"
        mkdir -p "${git_config_dir}"
        gitignore_global="${git_config_dir}/ignore"
        forgit::ignore::get \
            Backup GPG Linux Tags Vagrant Vim VisualStudioCode Windows Xcode macOS \
            > "${gitignore_global}"
        echo -e "### direnv ###\n.envrc\n" >> "${gitignore_global}"
        echo -e "### Zsh ###\n*.zwc\n" >> "${gitignore_global}"
        echo -e "### fnm ###\n.nvm\n.node-version\n" >> "${gitignore_global}"
    ' \
    run-atpull atpull='%atclone' \
    atload="
        alias grst='gcf'
        alias gst='gss'
    "
zinit light wfxr/forgit

zinit ice wait=0 lucid \
    atload="alias cdu='cd-gitroot'"
zinit light mollifier/cd-gitroot

zinit ice wait=0 lucid \
    atinit='. "${ZDOTDIR}/.zshrc_lazy"'
zinit light zdharma/null
