return {
    -- Install LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      -- 'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },

    config = function()
        local lspconfig = require("lspconfig")
        local mason-lspconfig = require("mason-lspconfig")

        -- local client_capabilities = vim.lsp.protocol.make_client_capabilities()
        -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
        -- local capabilities = require("blink.cmp").get_lsp_capabilities(client_capabilities)

        local capabilies = require("utils.lsp").capabilities
        local on_attach = require("utils.lsp").on_attach

        require("utils.diagnostics").setup()


        -- Enable the following language servers
        --  Add any additional override configuration in the following tables. Available keys are:
        --  - cmd (table): Override the default command used to start the server
        --  - filetypes (table): Override the default list of associated filetypes for the server
        --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
        --  - settings (table): Override the default settings passed when initializing the server.
        local servers = {
            -- See `:help lspconfig-all` for a list of all the pre-configured LSPs

            lua_ls = {},
            nixd = {},
            clangd = {},
        }

        -- Ensure the servers and tools above are installed

        -- local ensure_installed = vim.tbl_keys(servers or {})
        -- vim.list_extend(ensure_installed, {
        --     "stylua", -- Used to format Lua code
        --     "prettierd", -- Used to format javascript and typescript code
        -- })
        -- require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        for server, config in pairs(servers) do
            mason-lspconfig.setup({
                ensure_installed = server,
            })
            -- config.capabilities = lsp.capabilities
            config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
            config.on_attach = on_attach
            lspconfig[servers].setup(config)
        end,
    end
}
