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
-- Jump center screen
vim.keymap.set("n", "j", "jzz")
vim.keymap.set("n", "k", "kzz")
vim.keymap.set("n", "J", "5jzz")
vim.keymap.set("n", "K", "5kzz")
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
vim.keymap.set("n", "<leader><Enter>", "<CMD>nohlsearch<CR>")
-- Save file
vim.keymap.set("n", "<C-s>", "<CMD>update<CR>")
-- Removes white space
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = "*",
  command = "%s/\\s\\+$//e",
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
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- Plugins
require("lazy").setup({
  -- Repeat motion
  "tpope/vim-repeat",
  -- Edit surround
  "tpope/vim-surround",
  -- Commnet
  "tpope/vim-commentary",
  -- Format
  "sbdchd/neoformat",
  {
    -- Colorscheme
    "sainnhe/gruvbox-material",
    config = function()
      vim.g.gruvbox_material_foreground = "original"
      vim.g.gruvbox_material_background = "hard"
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
    end,
  },
  {
    -- Explorer
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup()
      vim.keymap.set("n", "<C-n>", "<CMD>NvimTreeToggle<CR>")
    end,
  },
  {
    -- Fuzzy file
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").setup()
      vim.keymap.set("n", "<leader>ff", "<CMD>Telescope find_files<CR>")
      vim.keymap.set("n", "<leader>fg", "<CMD>Telescope live_grep<CR>")
      vim.keymap.set("n", "<leader>fb", "<CMD>Telescope buffers<CR>")
      vim.keymap.set("n", "<leader>fc", "<CMD>Telescope commands<CR>")
    end,
  },
  {
    -- Git
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    -- Highlight code
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        highlight = {
          enable = true,
        },
      })
    end,
  },
  {
    -- Move motion
    "hadronized/hop.nvim",
    config = function()
      require("hop").setup()
      -- Keymap
      vim.keymap.set("n", "<leader><leader>f", "<CMD>HopWord<CR>")
      vim.keymap.set("n", "<leader><leader>s", "<CMD>HopChar1<CR>")
      vim.keymap.set("n", "<leader><leader>/", "<CMD>HopPattern<CR>")
      vim.keymap.set("n", "<leader><leader>j", "<CMD>HopLineStartAC<CR>")
      vim.keymap.set("n", "<leader><leader>k", "<CMD>HopLineStartBC<CR>")
    end,
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
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
          { name = "vsnip" },
        }),
      })
    end,
  },
  {
    -- Lsp
    "neovim/nvim-lspconfig",
    dependencies = {
      "Hoffs/omnisharp-extended-lsp.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      -- html
      lspconfig.html.setup({
        capabilities = capabilities,
      })
      -- css
      lspconfig.cssls.setup({
        capabilities = capabilities,
      })
      -- js, jsx, ts, tsx
      lspconfig.tsserver.setup({})
      -- c, c++
      lspconfig.clangd.setup({})
      -- Python
      lspconfig.pyright.setup({})
      -- C#
      lspconfig.omnisharp.setup({
        cmd = {
          "dotnet",
          vim.fn.stdpath("data") .. "/omnisharp/OmniSharp.dll",
        },
        handlers = {
          ["textDocument/definition"] = require("omnisharp_extended").definition_handler,
          ["textDocument/references"] = require("omnisharp_extended").references_handler,
          ["textDocument/implementation"] = require("omnisharp_extended").implementation_handler,
        },
      })
      -- Keymap
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
        end,
      })
    end,
  },
  {
    -- Debug
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("dapui").setup()
      local dap = require("dap")
      -- C#
      dap.adapters.coreclr = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/netcoredbg/netcoredbg",
        args = { "--interpreter=vscode" },
      }
      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          program = function()
            return vim.fn.input("Path to dll ", vim.fn.getcwd() .. "/bin/Debug/", "file")
          end,
        },
      }
      -- Keymap
      vim.keymap.set("n", "<leader>dui", function()
        require("dapui").toggle()
      end)
      vim.keymap.set("n", "<leader>dev", function()
        require("dapui").eval()
      end)
    end,
  },
})
