-- Settings --
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.wrap = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.cursorline = true
vim.opt.clipboard = ""
vim.opt.signcolumn = "auto"
vim.opt.laststatus = 2
vim.opt.background = "dark"
vim.opt.termguicolors = true
-- Search --
vim.opt.hlsearch = true
vim.opt.ignorecase = true
-- Split --
vim.opt.splitbelow = true
vim.opt.splitright = true
-- Indent --
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
-- Undo --
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
-- Map leader <Space> --
vim.g.mapleader = " "
local keymap = vim.keymap.set
local opts = { silent = true }
-- Navigation --
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
-- Jump center screen --
keymap("n", "j", "jzz", opts)
keymap("n", "k", "kzz", opts)
keymap("n", "J", "10jzz", opts)
keymap("n", "K", "10kzz", opts)
-- Next & Previous highlight search --
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
-- Indent block --
keymap("v", ">", ">gv", opts)
keymap("v", "<", "<gv", opts)
-- Split window --
keymap("n", "<leader>_", "<CMD>split<CR>", opts)
keymap("n", "<leader>|", "<CMD>vsplit<CR>", opts)
-- Copy & Paste --
keymap("n", "<leader>p", '"+p', opts)
keymap("v", "<leader>p", '"+p', opts)
keymap("v", "<leader>y", '"+y', opts)
-- Disable highlight search --
keymap("n", "<leader>h", "<CMD>nohlsearch<CR>", opts)
-- Fuzzy finder --
keymap("n", "<leader>ff", "<CMD>Telescope find_files theme=ivy<CR>", opts)
keymap("n", "<leader>fb", "<CMD>Telescope buffers theme=ivy<CR>", opts)
keymap("n", "<leader>fg", "<CMD>Telescope live_grep theme=ivy<CR>", opts)
-- Explore --
keymap("n", "<C-e>", "<CMD>Oil<CR>", opts)
-- Lsp --
keymap("n", "<leader>e", vim.diagnostic.open_float, opts)
keymap("n", "]d", vim.diagnostic.goto_next, opts)
keymap("n", "[d", vim.diagnostic.goto_prev, opts)
-- Lazy.nvim --
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
-- Plugins --
require("lazy").setup({
    "sainnhe/gruvbox-material",
    "tpope/vim-repeat",
    "tpope/vim-surround",
    "tpope/vim-commentary",
    "easymotion/vim-easymotion",
    "ntpeters/vim-better-whitespace",
    "junegunn/vim-easy-align",
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config = function ()
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
                auto_install = true,
                highlight = {
                    enable = true
                }
            })
        end
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip"
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered()
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true })
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "vsnip" },
                    { name = "path" },
                    { name = "buffer" }
                })
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim"
        },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            require("mason").setup()
            require("mason-lspconfig").setup()
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = capabilities
                    })
                end
            })
        end
    }
})
-- Theme --
vim.g.gruvbox_material_foreground = "original"
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_visual = "reverse"
vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
vim.g.gruvbox_material_transparent_background = 1
vim.g.gruvbox_material_enable_bold = 1
vim.cmd("colorscheme gruvbox-material")
-- Cursor line --
vim.api.nvim_set_hl(0, "CursorLine", {})
vim.api.nvim_set_hl(0, "CursorLineNR", { bg = NONE, fg = "#fabd2f", bold = true })
-- Lsp --
vim.api.nvim_create_user_command("LspDiagnostics", "Telescope diagnostics bufnr=0 theme=ivy", {})
vim.api.nvim_create_user_command("LspHover", vim.lsp.buf.hover, {})
vim.api.nvim_create_user_command("LspSignatureHelp", vim.lsp.buf.signature_help, {})
vim.api.nvim_create_user_command("LspRename", vim.lsp.buf.rename, {})
vim.api.nvim_create_user_command("LspCodeAction", vim.lsp.buf.code_action, {})
vim.api.nvim_create_user_command("LspFormat", function()
    vim.lsp.buf.format { async = true }
end, {})
