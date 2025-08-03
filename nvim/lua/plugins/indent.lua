return {
  "lukas-reineke/indent-blankline.nvim",
  event = "VeryLazy",
  opts = {
    indent = {
      char = "▏",
    },
    scope = {
      enabled = false,
    },
  },
  config = function(_, opts)
    require("ibl").setup(opts)
  end,
}
