" Settings
set number
set mouse=a
set wrap
set cursorline
set noswapfile
set nobackup
set nowritebackup
set clipboard=
set signcolumn=auto
set background=dark
set termguicolors
set guioptions-=m "Remove menu bar
set guioptions-=T "Remove toolbar
set guioptions-=r "Remove right-hand scroll bar
set guioptions-=L "Remove left-hand scroll bar
set guifont=JetBrains_Mono:h12
" Disable cursor blink
set guicursor+=a:blinkon0
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
" Removes white space
autocmd BufWritePre * :%s/\s\+$//e
" Undo
set undofile
if !isdirectory($HOME.'/.vim')
    call mkdir($HOME.'/.vim', '', 0770)
endif
if !isdirectory($HOME.'/.vim/undo')
    call mkdir($HOME.'/.vim/undo', '', 0700)
endif
set undodir=$HOME/.vim/undo
" Map leader <Space>
let mapleader=' '
" Navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
" Resize
nmap <C-Left> <C-w><
nmap <C-Down> <C-w>-
nmap <C-Up> <C-w>+
nmap <C-Right> <C-w>>
" Jump center screen
nmap j jzz
nmap k kzz
nmap J 10jzz
nmap K 10kzz
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
nmap <leader>h <CMD>nohlsearch<CR>
" Fuzzy finder
nmap <leader>ff <CMD>Files<CR>
nmap <leader>fb <CMD>Buffers<CR>
nmap <leader>fg <CMD>Rg<CR>
" Explore
nmap <C-n> <CMD>NERDTreeToggle<CR>
" Database query
vmap <expr> <C-q> db#op_exec()
" Vrc
nmap <leader>rc <CMD>call VrcQuery()<CR>
" vim-plug
call plug#begin()
    Plug 'sainnhe/gruvbox-material'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-dadbod'
    Plug 'preservim/nerdtree'
    Plug 'airblade/vim-gitgutter'
    Plug 'easymotion/vim-easymotion'
    Plug 'sheerun/vim-polyglot'
    Plug 'diepm/vim-rest-console'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'mattn/emmet-vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'OmniSharp/omnisharp-vim'
    Plug 'hsanson/vim-android'
    Plug 'dense-analysis/ale'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'puremourning/vimspector'
call plug#end()
" Gruvbox
let g:gruvbox_material_foreground = 'original'
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_visual = 'reverse'
let g:gruvbox_material_diagnostic_virtual_text = 'colored'
colorscheme gruvbox-material
highlight CursorLine ctermbg=NONE guibg=NONE
highlight CursorLineNR guifg=Orange
highlight Cursor guifg=Orange guibg=Black
" NerdTree
let g:NERDTreeMinimalUI = 1
" Fzf
let g:fzf_layout = { 'down': '40%' }
" Ale
let g:ale_linters_explicit = 1
let g:ale_typescript_tsserver_use_global = 1
let g:ale_java_javalsp_executable = $HOME.'/.vim/java-language-server/dist/lang_server_linux.sh'
let g:ale_linters = {
    \    'c': ['clangd'],
    \    'cpp': ['clangd'],
    \    'cs': ['OmniSharp'],
    \    'java': ['javalsp'],
    \    'javascript': ['tsserver'],
    \    'javascriptreact': ['tsserver'],
    \    'typescript': ['tsserver'],
    \    'typescriptreact': ['tsserver']
    \ }
" OmniSharp
let g:OmniSharp_server_use_net6 = 1
" Android
let g:android_sdk_path = $ANDROID_HOME
" Vrc
let g:vrc_set_default_mapping = 0
let g:vrc_show_command = 1
" Asyncomplete
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#ale#get_source_options({
    \    'priority': 10
    \ }))
