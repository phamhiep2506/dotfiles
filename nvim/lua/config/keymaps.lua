local map = vim.keymap.set

-- Navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Jump center screen
map("n", "j", "jzz")
map("n", "k", "kzz")
map("n", "J", "5jzz")
map("n", "K", "5kzz")

-- Next & Previous highlight search
map("n", "n", "nzz")
map("n", "N", "Nzz")

-- Indent block
map("v", ">", ">gv")
map("v", "<", "<gv")

-- Split window
map("n", "<leader>_", "<CMD>split<CR>")
map("n", "<leader>|", "<CMD>vsplit<CR>")

-- Copy & Paste
map("n", "<leader>p", '"+p')
map("v", "<leader>p", '"+p')
map("v", "<leader>y", '"+y')

-- Disable highlight search
map("n", "<leader><Enter>", "<CMD>nohlsearch<CR>")

-- Copy breakpoint
map("n", "<leader>cb", "<CMD>let @+=expand(\"%\") . ':' . line(\".\")<CR>")
