-- Enabling transparent backgrounn
local function background_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
end

return {
    -- Rose Pine Theme
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,
        priority = 1000,

        config = function()
            vim.cmd("colorscheme rose-pine-moon")
            background_transparency()
        end
    },

    -- Catppuccin Theme
    -- {
    --    "catppuccin/nvim",
    --     name = "catppuccin",
    --     lazy = false,
    --     priority = 1000,

    --     config = function()
    --         vim.cmd("colorscheme catppuccin")
    --         background_transparancy()
    --     end,
    -- },
}
