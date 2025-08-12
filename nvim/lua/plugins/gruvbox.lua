return {
  "ellisonleao/gruvbox.nvim",
  opts = {
    invert_selection = true,
    contrast = "hard",
    overrides = {
      SignColumn = { bg = "NONE" },
      NormalFloat = { bg = "NONE" },
      FloatBorder = { bg = "NONE" }
    }
  },
  config = function(_, opts)
    require("gruvbox").setup(opts)
    vim.cmd.colorscheme("gruvbox")
  end,
}
