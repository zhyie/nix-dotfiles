local opt = vim.opt
local indent = 4

----------------------------------------
-- tab and indentation
----------------------------------------
opt.tabstop = indent
opt.shiftwidth = indent
opt.softtabstop = indent
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

----------------------------------------
-- search settings
----------------------------------------
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

----------------------------------------
-- appearance settings
----------------------------------------
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.showmode = true
opt.showcmd = true
opt.title = true

----------------------------------------
-- behavior settings
----------------------------------------
opt.splitbelow = true
opt.splitright = true
opt.scrolloff = 10
opt.sidescrolloff = 10
opt.clipboard:append("unnamedplus")
opt.completeopt = { "menu", "menuone", "noselect" }
opt.wildmenu = true
opt.wildignorecase = true
opt.wildmode = "longest:full,full"

----------------------------------------
-- wrapping settings
----------------------------------------
opt.wrap = false
opt.linebreak = true
opt.breakindent = true

----------------------------------------
-- file handling
----------------------------------------
opt.swapfile = false
opt.undofile = true
opt.fileencoding = "utf-8"

----------------------------------------
-- misc
----------------------------------------
opt.mouse = "a"
opt.iskeyword:append("-")
opt.errorbells = false
