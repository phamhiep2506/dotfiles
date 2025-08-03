return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>ff", "<CMD>Telescope find_files<CR>", desc = "Find files" },
    { "<leader>fg", "<CMD>Telescope live_grep<CR>", desc = "Find strings" },
    { "<leader>fb", "<CMD>Telescope buffers<CR>", desc = "Find buffers" },
    { "<leader>fc", "<CMD>Telescope commands<CR>", desc = "Find commands" },
  },
}
