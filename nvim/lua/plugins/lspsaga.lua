return {
  "nvimdev/lspsaga.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>h", "<CMD>Lspsaga hover_doc<CR>", desc = "Lsp hover document" },
    { "<leader>ca", "<CMD>Lspsaga code_action<CR>", desc = "Lsp code action" },
    { "<leader>e", "<CMD>Lspsaga show_cursor_diagnostics<CR>", desc = "Lsp show cursor diagnostics" },
    { "gd", "<CMD>Lspsaga goto_definition<CR>", desc = "Lsp goto definition" },
    { "gt", "<CMD>Lspsaga goto_type_definition<CR>", desc = "Lsp goto type definition" },
    { "]d", "<CMD>Lspsaga diagnostic_jump_next<CR>", desc = "Lsp diagnostic jump next" },
    { "[d", "<CMD>Lspsaga diagnostic_jump_prev<CR>", desc = "Lsp diagnostic jump prev" },
    { "gi", "<CMD>Lspsaga finder imp<CR>", desc = "Lsp finder implement" },
  },
  opts = {
    lightbulb = {
      sign = false,
    },
  },
  config = function(_, opts)
    require("lspsaga").setup(opts)
  end,
}
