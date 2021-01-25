syntax enable

set shiftwidth=4
set tabstop=4
set number
set nowrap
set hidden

set list
set lcs=tab:\¦.
highlight SpecialKey ctermfg=8 guifg=DimGrey

" Color
set background=dark
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

call plug#begin('~/.vim/plugged')
  Plug 'morhetz/gruvbox'
  Plug 'preservim/nerdtree'
  Plug 'prettier/vim-prettier'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'sheerun/vim-polyglot'
  Plug 'mattn/emmet-vim'
  Plug 'tpope/vim-surround'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'mbbill/undotree'
  Plug 'tpope/vim-fugitive'
  Plug 'preservim/nerdcommenter'
  Plug 'kien/ctrlp.vim'
call plug#end()

let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Config plugin whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" Shortcut  NerdTree Vim
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

nnoremap <F5> :UndotreeToggle<CR>

" Bubble single lines
nmap <C-Up> ddkP
nmap <C-Down> ddp
" Bubble multiple lines
vmap <C-Up> xkP`[V`]
vmap <C-Down> xp`[V`]

noremap <Leader>y "+y
noremap <Leader>p "+p

nmap <Leader>py <Plug>(Prettier)

nmap <leader>v :tabedit $MYVIMRC<CR>
