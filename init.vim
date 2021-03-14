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
"   Plug 'morhetz/gruvbox'
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'preservim/nerdtree'
    Plug 'vim-airline/vim-airline'
    Plug 'preservim/nerdcommenter'
    Plug 'jiangmiao/auto-pairs'
    Plug 'Yggdroot/indentLine'
    Plug 'tpope/vim-surround'
    Plug 'sheerun/vim-polyglot'
"   Plug 'ntpeters/vim-better-whitespace'
    Plug 'preservim/tagbar'
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
"   Plug 'ryanoasis/vim-devicons'
"   Plug 'nvim-lua/diagnostic-nvim'
    Plug 'prettier/vim-prettier', {
        \ 'do': 'yarn install',
        \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
    Plug 'mattn/emmet-vim'
    Plug 'kien/ctrlp.vim'
    Plug 'ap/vim-css-color'
    Plug 'terryma/vim-multiple-cursors'
call plug#end()



"#################################################
"#             Plugin Setting                    #
"#################################################
"
"let g:gruvbox_contrast_dark = 'hard'
colorscheme dracula

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

map <C-L> 20zl 
map <C-H> 20zh 


" Edit init.vim
nmap <leader>v :tabedit ~/.config/nvim/init.vim<CR>


" NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Tagbar
nmap <F8> :TagbarToggle<CR>


nmap <Leader>py <Plug>(Prettier)

"#################################################
"#             LSP                               #
"#################################################
"
autocmd BufEnter * lua require'completion'.on_attach()


" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" possible value: 'UltiSnips', 'Neosnippet', 'vim-vsnip', 'snippets.nvim'
let g:completion_enable_snippet = 'UltiSnips'

:lua << EOF

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=240 guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=240 guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=240 guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
--

--local servers = { "pyright", "rust_analyzer", "tsserver" }
--for _, lsp in ipairs(servers) do
  --nvim_lsp[lsp].setup { on_attach = on_attach }
--end
--
--
--

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

nvim_lsp.html.setup {
    capabilities = capabilities,
    on_attach=on_attach
}

nvim_lsp.cssls.setup{
    capabilities = capabilities,
    on_attach=on_attach
}

nvim_lsp.tsserver.setup{
    capabilities = capabilities,
    on_attach=on_attach
}

EOF
