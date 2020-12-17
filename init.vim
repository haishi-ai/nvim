scriptencoding utf-8
set encoding=utf-8
set fileencodings=utf-8,sjis
set fileencodings=utf-8
set path+=../**/*,../../**/*,../../../**/*,../../../../**/*
set tags+=tags;

if has('win32') || has('win64')
    let $NVIMDIR=$USERPROFILE . '/AppData'
    let s:config_home = $NVIMDIR . '/nvim'
    let s:cache_home = empty($HOME . '/.cache') ? expand($HOME . '/.cache') : $XDG_CACHE_HOME
elseif has('unix')
    let $NVIMDIR=$XDG_CONFIG . '/nvim'
    let s:config_home = empty($XDG_CONFIG_HOME) ? expand('~/.config/nvim') : $XDG_CONFIG_HOME
    let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
end

" directory configuration
if !isdirectory(s:cache_home)
    :call mkdir(s:cache_home, "p")
endif

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
let &backupdir=tmpdir . '/bk'
let &directory=tmpdir . '/swap'
let &undodir=tmpdir . '/undo'

" マウスの設定
set mouse=a
set clipboard=unnamedplus

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
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

"  dein installation
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    echo "### installing dein...."
    call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
  endif
  let &runtimepath = s:dein_repo_dir . "," . &runtimepath
end

"  path
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:toml = s:config_home . '/toml/dein.toml'
  let s:lazy_toml = s:config_home . '/toml/dein_lazy.toml'

  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy' : 1})

  call dein#end()
  call dein#save_state()
endif
"  install new plugins
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" dein.vim }}}
