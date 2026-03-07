return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',

    config = function()
        local treesitter = require('nvim-treesitter')
        local filetypes = { 'lua', 'nix', 'c', },

        treesitter.setup({})
        treesitter.install({ filetypes })

        vim.api.nvim_create_autocmd('FileType', {
          pattern = { '*' },
          callback = function() vim.treesitter.start() end,
        })
    end
}
