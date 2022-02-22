set ruler
set number relativenumber
set scrolloff=10
set cursorline
hi cursorline cterm=none term=none
highlight CursorLine ctermbg=236
set smarttab
set tabstop=4
set shiftwidth=4
set ignorecase
set hlsearch
set incsearch
set showmatch
syntax enable
set confirm
set wrap
set backspace=indent,eol,start
set noerrorbells
set encoding=utf8
set ffs=unix,dos,mac
set nobackup
set nowb
set noswapfile
set ai
set si
set autoindent

call plug#begin("~/.vim/plugged")
	Plug 'Mofiqul/vscode.nvim'
call plug#end()

let g:vscode_style = "dark"
let g:vscode_transparency = 1
let g:vscode_italic_comment = 1
let g:vscode_disable_nvimtree_bg = v:true 

colorscheme vscode
