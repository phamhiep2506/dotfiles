local o = vim.opt

-- Base
o.number = true
o.relativenumber = true
o.mouse = "a"
o.wrap = true
o.cursorline = true
o.clipboard = ""
o.background = "dark"
o.termguicolors = true
o.backup = false
o.writebackup = false
o.swapfile = false
o.updatetime = 300
o.hidden = true
o.laststatus = 3

-- Search
o.hlsearch = true
o.ignorecase = true

-- Split
o.splitbelow = true
o.splitright = true

-- Indent
o.autoindent = true
o.expandtab = true
o.shiftwidth = 2

-- Undo
o.undofile = true

-- Map leader <Space>
vim.g.mapleader = " "

-- Neovide
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h12"
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_cursor_animation_length = 0
end
