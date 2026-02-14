return {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },

    config = function()
        local lualine = require('lualine')

        lualine.setup({
            options = {
                themes = 'modus-vivendi',
                section_separators = '',
                component_separators = '',
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'diagnostics'},
                lualine_c = {'filename'},
                lualine_x = {'encoding', 'filetype'},
                lualine_y = {'diff', 'branch'},
                lualine_z = {'location'},
            },
        })
    end,
}
