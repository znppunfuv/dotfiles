""" Neovim provider """
" Doc: https://neovim.io/doc/user/provider.html
let g:loaded_python_provider = 1
let g:python_host_prog       = ''
let g:loaded_ruby_provider   = 1
let g:loaded_node_provider   = 1

""" XDG Base Directory """
" Doc: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
let g:xdg_config_home = !empty($XDG_CONFIG_HOME)
    \ ? $XDG_CONFIG_HOME
    \ : $HOME . '/.config'
let g:xdg_cache_home  = !empty($XDG_CACHE_HOME)
    \ ? $XDG_CACHE_HOME
    \ : $HOME . '/.cache'
let g:xdg_data_home   = !empty($XDG_DATA_HOME)
    \ ? $XDG_DATA_HOME
    \ : $HOME . '/.local/share'

""" Options """
set hidden
set updatetime=100
" Indent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smartindent
" Split
set splitright
set splitbelow
" Look and Feel
set termguicolors
set cursorcolumn
set cursorline
set colorcolumn=80
set number
set relativenumber
set pumblend=15
set winblend=15
set showtabline=2
set cmdheight=2
set signcolumn=yes
" Backup
set nobackup
set nowritebackup
" For all operations
set clipboard+=unnamedplus
" All previous modes
set mouse=a
" Automatically wrap left and right
set whichwrap=b,s,h,l,<,>,[,]
" Same style as the ins-completion-menu
set wildoptions=pum
" Also shows partial off-screen results in a preview window
set inccommand=split

""" Mapping """
" Change <Leader>
" Doc: https://neovim.io/doc/user/map.html#mapleader
let g:mapleader = "\<space>"
" Move through wrapped lines
nn j gj
nn k gk
vn j gj
vn k gk
" Paste over without overwriting register
xn <silent>p "_dP
" Clear last search highlighting
nmap <silent><Esc><Esc> :noh<CR> :call clearmatches()<CR>

""" Indent """
aug FileTypeIndent
    au!
    au FileType html        setl ts=2 sw=2 sts=2 et
    au FileType css         setl ts=2 sw=2 sts=2 et
    au FileType javascript* setl ts=2 sw=2 sts=2 et
    au FileType typescript* setl ts=2 sw=2 sts=2 et
    au FileType json        setl ts=2 sw=2 sts=2 et
    au FileType yml*        setl ts=2 sw=2 sts=2 et
    au FileType toml        setl ts=2 sw=2 sts=2 et
aug END

""" Others """
" Auto close quickfix
aug Quickfix
    au!
    au WinEnter *
        \ if winnr('$') == 1 && getbufvar(winbufnr(winnr()), '&buftype') == 'quickfix'
            \ | q
        \ | endif
aug END

""" Plugin """
" dein.vim
" Repo: https://github.com/Shougo/dein.vim
exec 'source' g:xdg_config_home . '/nvim/plugin/dein/dein.vim'
