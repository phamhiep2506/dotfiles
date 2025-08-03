return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<A-.>", "<CMD>bnext<CR>", desc = "Next buffer" },
    { "<A-,>", "<CMD>bprevious<CR>", desc = "Previous buffer" },
    { "<A-c>", "<CMD>Bdelete<CR>", desc = "Delete buffer" },
  },
  opts = {
    options = {
      offsets = {
        {
          filetype = "neo-tree",
          text = "File Explorer",
          text_align = "center",
          separator = true,
        },
      },
    },
  },
}
