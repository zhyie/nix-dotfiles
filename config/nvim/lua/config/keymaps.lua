-- space key as <Leader>
vim.g.mapleader = " "

-- space key as <LocalLeader>
vim.g.maplocalleader = " "

-- Remain in visual mode when indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Nvim Tree explorer
vim.keymap.set("n", "<leader> ", "<Cmd>NvimTreeFocus<CR>", { desc = "Focus on File Explorer" })
vim.keymap.set("n", "<leader> ", "<Cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })

