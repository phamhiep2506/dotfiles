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
" Set map leader <Space>
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
" Plugins
let data_dir = has("nvim") ? stdpath("data") . "/site" : "~/.vim"
if empty(glob(data_dir . "/autoload/plug.vim"))
    silent execute "!curl -fLo ".data_dir."/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
    Plug 'morhetz/gruvbox'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-vinegar'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'easymotion/vim-easymotion'
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'junegunn/vim-easy-align'
    Plug 'sheerun/vim-polyglot'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }
    Plug 'OmniSharp/omnisharp-vim'
    Plug 'dense-analysis/ale'
call plug#end()
" Gruvbox
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_sign_column = "bg0"
let g:gruvbox_guisp_fallback = "bg"
colorscheme gruvbox
" Cursor line
highlight clear CursorLine
highlight CursorLineNR guibg=NONE guifg =#fabd2f gui=bold
" Fzf
let g:fzf_layout = { "window": "enew" }
" Git gutter
let g:gitgutter_map_keys = 0
" Ale
let g:ale_virtualtext_cursor = "disabled"
let g:ale_linters_explicit = 1
let g:ale_linters = { "cs": ["OmniSharp"] }
" OmniSharp
let g:OmniSharp_server_use_net6 = 1
" Coc.nvim
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
command! CocDocumentation call CocActionAsync("doHover")
