syntax on
set termguicolors
set noshowmode

set tabstop=2
set softtabstop=2
set expandtab

set smartindent
set shiftwidth=2

set number
set relativenumber
set numberwidth=4
set signcolumn=no

set scrolloff=8
set mouse=

set undofile

set ignorecase
set smartcase

set splitbelow
set splitright

set background=dark

let mapleader="\<Space>"
let g:coq_settings = { 'auto_start': 'shut-up' }
let test#strategy = "neovim"
lua require('plugins')

nnoremap <leader>h :set hlsearch! hlsearch?<cr>
nnoremap <leader>bc :%bd\|e#\|bd#<cr>

