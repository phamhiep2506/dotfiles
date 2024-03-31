-- Settings
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.wrap = true
vim.opt.cursorline = true
vim.opt.clipboard = ""
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
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
-- Undo
vim.opt.undofile = true
-- Map leader <Space>
vim.g.mapleader = " "
-- Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
-- Resize
vim.keymap.set("n", "<C-Left>", "<C-w><")
vim.keymap.set("n", "<C-Down>", "<C-w>-")
vim.keymap.set("n", "<C-Up>", "<C-w>+")
vim.keymap.set("n", "<C-Right>", "<C-w>>")
-- Jump center screen
vim.keymap.set("n", "j", "jzz")
vim.keymap.set("n", "k", "kzz")
vim.keymap.set("n", "J", "10jzz")
vim.keymap.set("n", "K", "10kzz")
-- Next & Previous highlight search
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
-- Indent block
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
-- Split window
vim.keymap.set("n", "<leader>_", "<CMD>split<CR>")
vim.keymap.set("n", "<leader>|", "<CMD>vsplit<CR>")
-- Copy & Paste
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>y", '"+y')
-- Disable highlight search
vim.keymap.set("n", "<ESC>", "<CMD>nohlsearch<CR>")
-- Exit normal mode terminal
vim.keymap.set("t", "<ESC><ESC>", "<C-\\><C-n>")
-- Removes white space
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = "*",
  command = "%s/\\s\\+$//e"
})
-- Bootstrap lazy.vim
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
--Plugins
require("lazy").setup({
  -- Repeat motion
  "tpope/vim-repeat",
  -- Edit surround
  "tpope/vim-surround",
  -- Defaults everyone
  "tpope/vim-sensible",
  -- Set buffer
  "tpope/vim-sleuth",
  -- Commnet
  "tpope/vim-commentary",
  -- Env
  "tpope/vim-dotenv",
  -- Git
  "tpope/vim-fugitive",
  -- Move motion
  "easymotion/vim-easymotion",
  -- Emmet
  "mattn/emmet-vim",
  {
    -- Database
    "tpope/vim-dadbod",
    config = function()
      vim.cmd([[
        vmap <expr> <C-q> db#op_exec()
      ]])
    end
  },
  {
    -- Colorscheme
    "sainnhe/gruvbox-material",
    config = function()
      vim.g.gruvbox_material_foreground = "original"
      vim.g.gruvbox_material_background  = "hard"
      vim.g.gruvbox_material_visual = "reverse"
      vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_diagnostic_text_highlight = 1
      vim.g.gruvbox_material_diagnostic_line_highlight = 1
      vim.g.gruvbox_material_better_performance = 1
      vim.cmd("colorscheme gruvbox-material")
      vim.api.nvim_set_hl(0, "CursorLine", { fg = "none", bg = "none" })
      vim.api.nvim_set_hl(0, "CursorLineNR", { fg = "orange", bold = true })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    end
  },
  {
    -- Explorer
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("nvim-tree").setup()
      vim.keymap.set("n", "<C-n>", "<CMD>NvimTreeToggle<CR>")
    end
  },
  {
    -- Fuzzy file
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("telescope").setup()
      vim.keymap.set("n", "<leader>ff", "<CMD>Telescope find_files<CR>")
      vim.keymap.set("n", "<leader>fg", "<CMD>Telescope live_grep<CR>")
      vim.keymap.set("n", "<leader>fb", "<CMD>Telescope buffers<CR>")
      vim.keymap.set("n", "<leader>fc", "<CMD>Telescope commands<CR>")
    end
  },
  {
    -- Git
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  },
  {
    -- Highlight code
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true
        }
      })
    end
  },
  {
    -- Complete
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
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
          { name = "buffer" },
          { name = "path" },
          { name = "vsnip" },
          { name = "nvim_lsp_signature_help" }
        })
      })
    end
  },
  {
    -- Lsp
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "Hoffs/omnisharp-extended-lsp.nvim"
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
      local handlers = {
        -- Auto start lsp
        function(server_name)
          require("lspconfig")[server_name].setup({
            handlers = {
              ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
              ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
            }
          })
        end,
        -- Custom lsp omnisharp
        ["omnisharp"] = function()
          require("lspconfig").omnisharp.setup({
            handlers = {
              ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
              ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
              ["textDocument/definition"] = require("omnisharp_extended").definition_handler,
              ["textDocument/references"] = require("omnisharp_extended").references_handler,
              ["textDocument/implementation"] = require("omnisharp_extended").implementation_handler
            }
          })
        end
      }
      require("mason-lspconfig").setup_handlers(handlers)
      -- Diagnostic border
      vim.diagnostic.config({
        float = {
          border = "rounded"
        }
      })
      -- Keymap
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
      -- Keymap LspAttach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Buffer map
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>fm", function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end
      })
    end
  },
  {
    -- Debug
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio"
    },
    config = function()
      require("dapui").setup()
      local dap = require("dap")
      -- C#
      dap.adapters.coreclr = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg",
        args = { "--interpreter=vscode" }
      }
      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          program = function()
            return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
          end
        }
      }
      -- Keymap
      vim.keymap.set("n", "<leader>dui", function() require("dapui").toggle() end)
    end
  }
})
