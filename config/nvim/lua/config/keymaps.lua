local set = vim.keymap.set

----------------------------------------
-- Center screen when jumping
----------------------------------------
set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

----------------------------------------
-- Buffer navigation
----------------------------------------
set("n", "<leader>bn", "<Cmd>bnext<CR>", { desc = "Next buffer" })
set("n", "<leader>bp", "<Cmd>bprevious<CR>", { desc = "Previous buffer" })

----------------------------------------
-- Better window navigation
----------------------------------------
set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

----------------------------------------
-- Splitting & Resizing
----------------------------------------
set("n", "<leader>sv", "<Cmd>vsplit<CR>", { desc = "Split window vertically" })
set("n", "<leader>sh", "<Cmd>split<CR>", { desc = "Split window horizontally" })
set("n", "<C-Up>", "<Cmd>resize +2<CR>", { desc = "Increase window height" })
set("n", "<C-Down>", "<Cmd>resize -2<CR>", { desc = "Decrease window height" })
set("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
set("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Increase window width" })

----------------------------------------
-- Better J behavior
----------------------------------------
set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

----------------------------------------
-- Remain visual mode when indenting
----------------------------------------
set("v", "<", "<gv", { desc = "Indent left and reselect" })
set("v", ">", ">gv", { desc = "Indent right and reselect" })

----------------------------------------
-- Nvim Tree explorer
----------------------------------------
set("n", "<leader>e", "<Cmd>NvimTreeFocus<CR>", { desc = "Focus on File Explorer" })
set("n", "<leader>ee", "<Cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })
