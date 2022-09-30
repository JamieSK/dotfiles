syntax on
set termguicolors
set noshowmode

set tabstop=2
set softtabstop=2
set expandtab

set smartindent
set shiftwidth=2

set number
set numberwidth=4

set scrolloff=8

set undofile

set ignorecase
set smartcase

set splitbelow
set splitright

set background=dark
colorscheme solarized-flat

let mapleader="\<Space>"
let g:coq_settings = { 'auto_start': 'shut-up' }
lua require('plugins')

nnoremap <leader>t <cmd>CHADopen<cr>
nnoremap <leader>? <cmd>Cheatsheet<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>

