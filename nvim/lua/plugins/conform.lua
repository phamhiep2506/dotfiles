return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>fm", function() require("conform").format({ async = true }) end, desc = "Format code" },
  },
  opts = {
    default_format_opts = {
      timeout_ms = "5000",
    },
    formatters_by_ft = {
      lua = { "stylua" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      cs = { "csharpier" },
      cmake = { "cmake_format" },
      html = { "prettier" },
      css = { "prettier" },
      sass = { "prettier" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      python = { "black" },
      kotlin = { "ktfmt" },
    },
  },
}
