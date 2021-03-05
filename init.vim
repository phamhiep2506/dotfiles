"#################################################
"#             VS Setting                        #
"#################################################
"
syntax enable
set encoding=UTF-8
set mouse=a
set shiftwidth=4
set tabstop=4
set expandtab
set number
set nowrap
set hidden

" Color
set background=dark
set termguicolors
set t_Co=256

" Configure backspace so it acts as it should act
set backspace=eol,start,indent

" Ignore case when searching
set ignorecase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

set clipboard+=unnamedplus


let mapleader = ","

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>




"#################################################
"#             Plugin                            #
"#################################################
"
call plug#begin(expand('~/.config/nvim/plugged'))
  Plug 'morhetz/gruvbox' "Themes
  Plug 'preservim/nerdtree' "File Manager
  Plug 'ryanoasis/vim-devicons' "Icons
  Plug 'preservim/nerdcommenter' "Comment
  Plug 'vim-airline/vim-airline'
  Plug 'jiangmiao/auto-pairs'
  Plug 'Yggdroot/indentLine'
  Plug 'preservim/tagbar'
  Plug 'tpope/vim-surround'
  Plug 'sheerun/vim-polyglot'
  Plug 'ntpeters/vim-better-whitespace'
call plug#end()




"#################################################
"#             Plugin Setting                    #
"#################################################
"
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox

" white space auto remove
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0



"#################################################
"#             Mapping                           #
"#################################################
"
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Bubble single lines
nmap <C-Up> ddkP
nmap <C-Down> ddp

" Bubble multiple lines
vmap <C-Up> xkP`[V`]
vmap <C-Down> xp`[V`]

" clipb
noremap <Leader>y "+y
noremap <Leader>p "+p

" Edit init.vim
nmap <leader>v :tabedit ~/.config/nvim/init.vim<CR>

" NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Tagbar
nmap <F8> :TagbarToggle<CR>

"#################################################
"#             LSP                               #
"#################################################
"
