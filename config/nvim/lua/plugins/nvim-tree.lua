return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        -- Remove background from NvimTree
        -- vim.cmd([[hi NvimTreeNormal guibg=NONE ctermbg=NONE]])

        -- setup with options
        require("nvim-tree").setup({
            filters = {
                dotfiles = false,
            },
            view = {
                adaptive_size = true,
            },
        })
    end
}
