return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  keys = {
    { "]g", "<CMD>Gitsigns next_hunk<CR>", desc = "Next hunk" },
    { "[g", "<CMD>Gitsigns prev_hunk<CR>", desc = "Prev hunk" },
    { "<leader>gp", "<CMD>Gitsigns preview_hunk<CR>", desc = "Preview hunk" },
    { "<leader>gb", "<CMD>Gitsigns blame_line<CR>", desc = "Show blame line" },
    { "<leader>gd", "<CMD>Gitsigns diffthis<CR>", desc = "Show diff" },
  },
  opts = {
    preview_config = {
      border = "rounded",
    },
  },
}
