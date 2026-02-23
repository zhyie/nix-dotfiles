return {
    "goolord/alpha-nvim",
    -- dependencies = { 'nvim-mini/mini.icons' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },

    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = {

            [[      |\__/,|   (`\     ]],
            [[    _.|o o  |_   ) )    ]],
            [[  -(((---(((--------    ]],

        }

        -- https://github.com/goolord/alpha-nvim/blob/main/lua/alpha/themes/dashboard.lua
        -- dashboard.section = {},

        alpha.setup(dashboard.config)
    end
}
