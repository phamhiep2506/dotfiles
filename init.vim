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
" set termguicolors
set t_Co=16

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
	Plug 'morhetz/gruvbox'
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'preservim/nerdtree'
    Plug 'vim-airline/vim-airline'
    Plug 'preservim/nerdcommenter'
    Plug 'jiangmiao/auto-pairs'
    Plug 'Yggdroot/indentLine'
    Plug 'tpope/vim-surround'
    Plug 'sheerun/vim-polyglot'
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'preservim/tagbar'
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
call plug#end()



"#################################################
"#             Plugin Setting                    #
"#################################################
"
"let g:gruvbox_contrast_dark = 'hard'
colorscheme dracula

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
"



autocmd BufEnter * lua require'completion'.on_attach()

":lua << EOF
    "local capabilities = vim.lsp.protocol.make_client_capabilities()
    "capabilities.textDocument.completion.completionItem.snippetSupport = true

    "require'lspconfig'.html.setup {
        "capabilities = capabilities,
        "on_attach=require'completion'.on_attach
    "}

    "require'lspconfig'.cssls.setup{
        "capabilities = capabilities,
        "on_attach=require'completion'.on_attach
    "}

    "require'lspconfig'.tsserver.setup{
        "capabilities = capabilities,
        "on_attach=require'completion'.on_attach
    "}

"EOF

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" possible value: 'UltiSnips', 'Neosnippet', 'vim-vsnip', 'snippets.nvim'
let g:completion_enable_snippet = 'UltiSnips'



"#################################################
"#             LSP Maping                        #
"#################################################
"
"
"nnoremap <silent> K                 <cmd>lua vim.lsp.buf.hover()<CR>
"nnoremap <silent> [d                <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
"nnoremap <silent> ]d                <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
"nnoremap <silent> <space>rn         <cmd>lua vim.lsp.buf.rename()<CR>
"nnoremap <silent> <space>q          <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
"nnoremap <silent> gD                <cmd>lua vim.lsp.buf.definition()<CR>


"nnoremap <silent> gD            <Cmd>lua vim.lsp.buf.declaration()<CR>
"nnoremap <silent> gd            <Cmd>lua vim.lsp.buf.definition()<CR>
"nnoremap <silent> K             <Cmd>lua vim.lsp.buf.hover()<CR>
"nnoremap <silent> gi            <cmd>lua vim.lsp.buf.implementation()<CR>
"nnoremap <silent> <C-k>         <cmd>lua vim.lsp.buf.signature_help()<CR>
"nnoremap <silent> <space>wa     <cmd>lua vim.lsp.buf.add_workspace_folder()<CR>
"nnoremap <silent> <space>wr     <cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>
"nnoremap <silent> <space>wl     <cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
"nnoremap <silent> <space>D      <cmd>lua vim.lsp.buf.type_definition()<CR>
"nnoremap <silent> <space>rn     <cmd>lua vim.lsp.buf.rename()<CR>
"nnoremap <silent> gr            <cmd>lua vim.lsp.buf.references()<CR>
"nnoremap <silent> <space>e      <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
"nnoremap <silent> [d            <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
"nnoremap <silent> ]d            <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
"nnoremap <silent> <space>q      <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>


lua require('nvim_lsp_config')
