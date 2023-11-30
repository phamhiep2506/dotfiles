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
" Split window
set splitbelow
set splitright
" Indent
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
" Gvim
set linespace=3
set guifont=JetBrains_Mono:h13
set guioptions -=m " Remove menubar
set guioptions -=T " Remove toolbar
set guioptions -=r " Remove right scrollbar
set guioptions -=L " Remove left scrollbar
" Set map leader <Space>
let mapleader = " "
" Navigation
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l
" Resize
nnoremap <silent> <C-Left> <C-w><
nnoremap <silent> <C-Down> <C-w>-
nnoremap <silent> <C-Up> <C-w>+
nnoremap <silent> <C-Right> <C-w>>
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
nnoremap <silent> <leader>fk :Commands<CR>
" Explore
nnoremap <silent> <C-e> :Explore<CR>
" Plugins
call plug#begin()
    Plug 'morhetz/gruvbox'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-vinegar'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-sensible'
    Plug 'airblade/vim-gitgutter'
    Plug 'easymotion/vim-easymotion'
    Plug 'sheerun/vim-polyglot'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'dense-analysis/ale'
    Plug 'OmniSharp/omnisharp-vim'
    Plug 'prabirshrestha/asyncomplete.vim'
call plug#end()
" Undercurl
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"
" Gruvbox
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_sign_column = "bg0"
let g:gruvbox_guisp_fallback = "fg"
colorscheme gruvbox
" Cursor line
highlight clear CursorLine
highlight CursorLineNr guibg=NONE guifg =#fabd2f gui=bold
" Fzf
let g:fzf_layout = { "window": "enew" }
let g:fzf_vim = {}
let g:fzf_vim.preview_window = []
" Git
let g:gitgutter_map_keys = 0
" Ale
let g:ale_virtualtext_cursor = "disabled"
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:ale_typescript_tsserver_use_global = 1
let g:ale_echo_msg_error_str = "E"
let g:ale_echo_msg_warning_str = "W"
let g:ale_echo_msg_format = "[%linter%] %s [%severity%]"
let g:ale_fixers = {
    \ "*": ["remove_trailing_lines", "trim_whitespace"]
    \ }
let g:ale_linters = {
    \ "cpp": ["clangd"],
    \ "cs": ["OmniSharp"],
    \ "javascript": ["tsserver"],
    \ "typescript": ["tsserver"]
    \ }
" OmniSharp
let g:OmniSharp_server_use_net6 = 1
" Asyncomplete
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#ale#get_source_options())
