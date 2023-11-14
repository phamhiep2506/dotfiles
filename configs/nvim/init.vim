set number
set mouse=a
set wrap
set noswapfile
set nobackup
set nowritebackup
set cursorline
set clipboard=
set signcolumn=auto
set laststatus=2
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
set tabstop=4
set shiftwidth=4
" Map leader <Space>
let mapleader = " "
" Navigation
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l
" Jump center screen
nnoremap <silent> j jzz
nnoremap <silent> k kzz
nnoremap <silent> J 10jzz
nnoremap <silent> K 10kzz
" Next & Previous highlight search
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
" Indent block
vnoremap <silent> > >gv
vnoremap <silent> < <gv
" Split window
nnoremap <silent> <leader>_ :split<CR>
nnoremap <silent> <leader>\| :vsplit<CR>
" Copy & Paste
nnoremap <silent> <leader>p "+p
vnoremap <silent> <leader>p "+p
vnoremap <silent> <leader>y "+y
" Disable highlight search
nnoremap <silent> <leader>h :nohlsearch<CR>
" Fuzzy finder
nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <leader>fg :Rg<CR>
nnoremap <silent> <leader>fk :Maps<CR>
" Explore
nnoremap <silent> <C-e> :Explore<CR>
" Download plugin.vim
let data_dir = has("nvim") ? stdpath("data") . "/site" : "~/.vim"
if empty(glob(data_dir . "/autoload/plug.vim"))
    silent execute "!curl -fLo ".data_dir."/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" Plugins
call plug#begin()
    Plug 'morhetz/gruvbox'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-vinegar'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'easymotion/vim-easymotion'
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
call plug#end()
" Gruvbox
let g:gruvbox_contrast_dark = "hard"
colorscheme gruvbox
" Cursor line
highlight clear CursorLine
highlight Normal guibg=NONE
highlight CursorLineNR guibg=NONE guifg =#fabd2f gui=bold
" Fzf
let g:fzf_layout = { "window": "enew" }
