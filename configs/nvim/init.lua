-- Settings
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.wrap = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.cursorline = true
vim.opt.clipboard = ""
vim.opt.signcolumn = "auto"
vim.opt.background = "dark"
vim.opt.termguicolors = true
-- Search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
-- Split
vim.opt.splitbelow = true
vim.opt.splitright = true
-- Indent
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
-- Undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
-- Map leader <Space>
vim.g.mapleader = " "
local keymap = vim.keymap.set
local opts = { silent = true }
-- Navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
-- Resize
keymap("n", "<C-Left>", "<C-w><", opts)
keymap("n", "<C-Down>", "<C-w>-", opts)
keymap("n", "<C-Up>", "<C-w>+", opts)
keymap("n", "<C-Right>", "<C-w>>", opts)
-- Jump center screen
keymap("n", "j", "jzz", opts)
keymap("n", "k", "kzz", opts)
keymap("n", "J", "10jzz", opts)
keymap("n", "K", "10kzz", opts)
-- Next & Previous highlight search
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
-- Indent block
keymap("v", ">", ">gv", opts)
keymap("v", "<", "<gv", opts)
-- Split window
keymap("n", "<leader>_", "<CMD>split<CR>", opts)
keymap("n", "<leader>|", "<CMD>vsplit<CR>", opts)
-- Copy & Paste
keymap("i", "<C-v>", "<C-r>*", opts)
keymap("n", "<leader>p", '"+p', opts)
keymap("v", "<leader>p", '"+p', opts)
keymap("v", "<leader>y", '"+y', opts)
-- Terminal
keymap("t", "<ESC>", "<C-\\><C-n>", opts)
vim.api.nvim_create_autocmd("TermOpen", {
    command = "setlocal nonumber"
})
-- Disable highlight search
keymap("n", "<leader>h", "<CMD>nohlsearch<CR>", opts)
-- Fuzzy finder
keymap("n", "<leader>ff", "<CMD>Telescope find_files theme=ivy<CR>", opts)
keymap("n", "<leader>fb", "<CMD>Telescope buffers theme=ivy<CR>", opts)
keymap("n", "<leader>fg", "<CMD>Telescope live_grep theme=ivy<CR>", opts)
-- Explore
keymap("n", "<C-e>", "<CMD>Oil<CR>", opts)
-- Lsp
keymap("n", "<leader>e", vim.diagnostic.open_float, opts)
keymap("n", "]d", vim.diagnostic.goto_next, opts)
keymap("n", "[d", vim.diagnostic.goto_prev, opts)
keymap("n", "<leader>q", vim.diagnostic.setloclist, opts)
-- Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)
-- Plugins
require("lazy").setup({
    "tpope/vim-repeat",
    "tpope/vim-surround",
    "tpope/vim-commentary",
    "easymotion/vim-easymotion",
    {
        "sainnhe/gruvbox-material",
        config = function()
            vim.g.gruvbox_material_foreground = "original"
            vim.g.gruvbox_material_background = "hard"
            vim.g.gruvbox_material_visual = "reverse"
            vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
            vim.cmd("colorscheme gruvbox-material")
            vim.api.nvim_set_hl(0, "CursorLine", {})
            vim.api.nvim_set_hl(0, "CursorLineNR", { bg = NONE, fg = "#fabd2f", bold = true })
        end
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config = function()
            require("telescope").setup()
        end
    },
    {
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup()
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                highlight = {
                    enable = false
                }
            })
        end
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
            "hrsh7th/cmp-nvim-lsp-signature-help"
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true })
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "vsnip" },
                    { name = "nvim_lsp_signature_help" }
                })
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            -- c,c++
            lspconfig.clangd.setup({})
            -- html,css
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            lspconfig.html.setup({
                capabilities = capabilities
            })
            lspconfig.cssls.setup({
                capabilities = capabilities
            })
            -- js,ts
            lspconfig.tsserver.setup({})
            -- omnisharp
            lspconfig.omnisharp.setup({
                cmd = { "dotnet", vim.env.HOME .. "/omnisharp/OmniSharp.dll" }
            })
        end
    }
})
