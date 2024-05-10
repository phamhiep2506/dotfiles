" Settings
set number
set mouse=a
set nowrap
set noswapfile
set cursorline
set clipboard=
set background=dark
set termguicolors
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
" Undo
set undofile
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
" Next & Previous highlight search
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
" Fuzzy finder
nmap <leader>ff <CMD>Files<CR>
nmap <leader>fb <CMD>Buffers<CR>
nmap <leader>fg <CMD>Rg<CR>
" Explore
nmap <C-n> <CMD>NERDTreeToggle<CR>
" vim-plug
call plug#begin()
    Plug 'sainnhe/gruvbox-material'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-sensible'
    Plug 'preservim/nerdtree'
    Plug 'easymotion/vim-easymotion'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
call plug#end()
" Gruvbox
let g:gruvbox_material_foreground = 'original'
let g:gruvbox_material_background = 'hard'
colorscheme gruvbox-material
highlight CursorLine ctermbg=NONE guibg=NONE
highlight CursorLineNR guifg=Orange
highlight Cursor guifg=Orange guibg=Black
" NerdTree
let g:NERDTreeMinimalUI = 1
" Fzf
let g:fzf_layout = { 'down': '40%' }
