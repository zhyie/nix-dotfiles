-- local servers = require("config.lsp").servers
-- local tools = require("config.lsp").tools

return {
    -- install lspconfig and use the config for LSPs
    { "neovim/nvim-lspconfig" },

    -- plugins to install LSPs within neovim
    { "mason-org/mason.nvim", opts = {} },

    -- automatically install and enable servers
    --{
      --  "mason-org/mason-lspconfig.nvim",
     --   opts = { ensure_installed = servers },
     --   dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" }
    --},

    -- for installing tools for servers
    --{
        --"WhoIsSethDaniel/mason-tool-installer.nvim",
       -- opts = { ensure_installed = tools },
      --  dependencies = { "mason-org/mason.nvim" }
    --},
}

