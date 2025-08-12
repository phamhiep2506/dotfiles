local hl = vim.api.nvim_set_hl
local autocmd = vim.api.nvim_create_autocmd

-- ColorScheme
autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    hl(0, "CursorLineNR", { fg = "#fabd2f", bg = "NONE", bold = true })
  end
})
