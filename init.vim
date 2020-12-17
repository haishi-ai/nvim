scriptencoding utf-8
set encoding=utf-8
set fileencodings=utf-8,sjis
set fileencodings=utf-8

" テンポラリファイル
let vimdir = $HOME . '/.config/nvim'
let tmpdir = vimdir . '/tmpdir'
if !isdirectory(tmpdir)
    call mkdir(tmpdir, 'p')
    call mkdir(tmpdir . '/bk', 'p')
    call mkdir(tmpdir . '/undo', 'p')
    call mkdir(tmpdir . '/swap', 'p')
endif

" TMP directory
set backupdir=$HOME/.config/nvim/tmpdir/bk
set directory=$HOME/.config/nvim/tmpdir/swap
set undodir=$HOME/.config/nvim/tmpdir/undo


" マウスの設定
set mouse=a
set clipboard=unnamedplus
set path+=../**/*,../../**/*,../../../**/*,../../../../**/*
set tags+=tags;

set number
set wrapscan
set showmatch
"set expandtab
set shiftwidth=4
set smartindent
set softtabstop=4
set clipboard+=unnamed
set wildmode=longest,full
set cursorline

"gvimのCdCurrentを設定 "
command! -nargs=0 CdCurrent cd %:p:h
noremap <silent>,cd :CdCurrent<CR>

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" ペースト
nnoremap <M-v> "*p
inoremap <M-v> <C-r><C-o>*
nnoremap <RightMouse> <C-r><C-o>*
nnoremap <RightMouse> "*p

" tab control
nnoremap <silent>tn :tabnext<CR>
nnoremap <silent>tc :tabnew<CR>

let g:python_host_prog = '/homes/d1007131/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/homes/d1007131/.pyenv/versions/neovim3/bin/python'

"=================== dein ============================
" dein.vim {{{
"  directory configuration
let s:config_home = empty($XDG_CONFIG_HOME) ? expand('~/.config') : $XDG_CONFIG_HOME
let s:dein_config_dir = s:config_home . '/nvim'
if !isdirectory(s:dein_config_dir)
    :call mkdir(s:dein_config_dir, "p")
endif
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:toml_file = s:dein_config_dir . '/toml/dein.toml'
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

echo s:cache_home
"  dein installation
if !isdirectory(s:dein_repo_dir)
  echo "install dein"
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

"  path
let &runtimepath = s:dein_repo_dir . "," . &runtimepath
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file, {'lazy': 0})
  call dein#end()
  call dein#save_state()
endif
"  install new plugins
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" dein.vim }}}
