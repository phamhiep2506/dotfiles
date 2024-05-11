" Setting
set number
set mouse=a
set nowrap
set clipboard=
" Search
set hlsearch
set ignorecase
" Split
set splitbelow
set splitright
" Indent
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
" Removes white space
autocmd BufWritePre * :%s/\s\+$//e
" Map leader <Space>
let mapleader=' '
" Navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
" Jump center screen
nmap j jzz
nmap k kzz
nmap J 5jzz
nmap K 5kzz
" Next & previous highlight search
nmap n nzz
nmap N Nzz
" Indent block
vmap > >gv
vmap < <gv
" Split window
nmap <leader>_ <CMD>split<CR>
nmap <leader>\| <CMD>vsplit<CR>
" Copy & Paste
nmap <leader>p "+p
vmap <leader>p "+p
vmap <leader>y "+y
" Disable highlight search
nmap <leader><Enter> <CMD>nohlsearch<CR>
