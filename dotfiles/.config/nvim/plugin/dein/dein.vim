" dein.vim
" Repo: https://github.com/Shougo/dein.vim
let s:dein_data_dir        = g:xdg_data_home   . '/nvim/plugin/dein'
let s:dein_repo_dir        = s:dein_data_dir   . '/repos/github.com/Shougo/dein.vim'
let s:dein_config_dir      = g:xdg_config_home . '/nvim/plugin/dein'
let g:dein#cache_directory = g:xdg_cache_home  . '/dein'

" Auto install
if !isdirectory(s:dein_data_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif

" Add the dein installation directory into runtimepath
execute 'set rtp+=' . s:dein_repo_dir

if dein#load_state(s:dein_data_dir)
    call dein#begin(s:dein_data_dir)
    let s:toml_dir = s:dein_config_dir . '/toml'
    call dein#load_toml(s:toml_dir . '/dein.toml',        { 'lazy': 0 })
    call dein#load_toml(s:toml_dir . '/completion.toml',  { 'lazy': 0 })
    call dein#load_toml(s:toml_dir . '/search.toml',      { 'lazy': 0 })
    call dein#load_toml(s:toml_dir . '/statusline.toml',  { 'lazy': 0 })
    call dein#load_toml(s:toml_dir . '/codingstyle.toml', { 'lazy': 0 })
    call dein#load_toml(s:toml_dir . '/dein_lazy.toml',   { 'lazy': 1 })
    call dein#load_toml(s:toml_dir . '/filetype.toml',    { 'lazy': 1 })
    call dein#end()
    call dein#save_state()
endif

" 'lifepillar/vim-solarized8'
colo solarized8

" Required
filetype plugin indent on
syntax enable

" Install not installed plugins on startup
if dein#check_install()
    call dein#install()
    " It is better than `:UpdateRemotePlugins` for dein
    call dein#remote_plugins()
    " Remove the disabled plugin
    call map(dein#check_clean(), "delete(v:val, 'rf')")
    call dein#recache_runtimepath()
endif
