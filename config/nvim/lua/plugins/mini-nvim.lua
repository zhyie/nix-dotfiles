-- mini.nvim
-- Library of 40+ independent Lua modules
-- https://github.com/nvim-mini/mini.nvim

return {
    -- { 'nvim-mini/mini.nvim', version = false },
    { 'nvim-mini/mini.comment', version = '*' },
    { 'nvim-mini/mini.move', version = '*' },
    { 'nvim-mini/mini.pairs', version = '*' },
    { 'nvim-mini/mini.surround', version = '*' },
    { 'nvim-mini/mini.indentscope', version = '*' },

    config = function()
        require('mini.comment').setup()
        require('mini.move').setup()
        require('mini.pairs').setup()
        require('mini.surround').setup()
        require('mini.indentscope').setup()
    end
}
