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
imap <C-v> <C-r>*
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
nmap <C-n> <CMD>Explore<CR>
" vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
    Plug 'sainnhe/gruvbox-material'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-vinegar'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-sensible'
    Plug 'airblade/vim-gitgutter'
    Plug 'easymotion/vim-easymotion'
    Plug 'sheerun/vim-polyglot'
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'mattn/emmet-vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'OmniSharp/omnisharp-vim'
    Plug 'hsanson/vim-android'
    Plug 'dense-analysis/ale'
    Plug 'prabirshrestha/asyncomplete.vim'
call plug#end()
" Gruvbox
let g:gruvbox_material_foreground = 'original'
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_visual = 'reverse'
let g:gruvbox_material_diagnostic_virtual_text = 'colored'
let g:gruvbox_material_transparent_background = '1'
colorscheme gruvbox-material
highlight CursorLine ctermbg=NONE guibg=NONE
highlight CursorLineNR guifg=#fabd2f
" Fzf
let g:fzf_layout = { 'down': '40%' }
" Ale
let g:ale_linters_explicit = 1
let g:ale_typescript_tsserver_use_global = 1
let g:ale_java_javalsp_executable= $HOME.'/.vim/java-language-server/dist/lang_server_linux.sh'
let g:ale_linters = {
    \    'c': ['ccls'],
    \    'cpp': ['ccls'],
    \    'cs': ['OmniSharp'],
    \    'java': ['javalsp'],
    \    'javascript': ['tsserver'],
    \    'typescript': ['tsserver']
    \ }
" OmniSharp
let g:OmniSharp_server_use_net6 = 1
" Android
let g:android_sdk_path = $ANDROID_HOME
" Asyncomplete
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#ale#get_source_options({
    \    'priority': 10
    \ }))
