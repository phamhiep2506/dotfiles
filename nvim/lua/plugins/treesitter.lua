return {
  "nvim-treesitter/nvim-treesitter",
  event = "VeryLazy",
  opts = {
    auto_install = true,
    highlight = {
      enable = true,
    },
  },
  config = function(_, opts)
    require("nvim-treesitter").setup(opts)
  end,
}
