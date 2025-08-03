return {
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason-lspconfig").setup()

    -- Icons
    local diagnostic = vim.diagnostic
    diagnostic.config({
      signs = {
        text = {
          [diagnostic.severity.ERROR] = "",
          [diagnostic.severity.WARN] = "",
          [diagnostic.severity.INFO] = "",
          [diagnostic.severity.HINT] = "",
        },
      },
    })
  end,
}
