syntax enable

set shiftwidth=4
set tabstop=4
set number
set nowrap

set list
set lcs=tab:\▏.,eol:⏎
highlight SpecialKey ctermfg=8 guifg=DimGrey

" Color
set background=dark
set t_Co=256
colorscheme molokai

" Configure backspace so it acts as it should act
set backspace=eol,start,indent

" Ignore case when searching
set ignorecase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

let mapleader = ","

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

