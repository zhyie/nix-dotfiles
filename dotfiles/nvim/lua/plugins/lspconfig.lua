-- local servers = require("languages").servers
-- local tools = require("languages").tools

-- local ensure_installed = vim.list_extend(servers, tools)

return {
    -- install lspconfig and use the config for LSPs
    { "neovim/nvim-lspconfig",
        dependencies = { "mason-org/mason.nvim", opts = {} },
    },

    -- plugins to install LSPs within neovim
    -- { "mason-org/mason.nvim", opts = {} },

    -- automatically install and enable servers
    -- { "mason-org/mason-lspconfig.nvim", opts = {}, },

    -- for installing tools for servers
    -- { "WhoIsSethDaniel/mason-tool-installer.nvim",
    --     opts = { ensure_installed = ensure_installed },
    --     dependencies = {
    --         "neovim/nvim-lspconfig",
    --         { "mason-org/mason.nvim", opts = {} },
    --         { "mason-org/mason-lspconfig.nvim", opts = {} },
    --     },
    -- },
}

