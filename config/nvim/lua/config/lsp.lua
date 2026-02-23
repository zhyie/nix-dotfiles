local servers = { "lua_ls", "nixd", "clangd", }

local utils_lsp = require("utils.lsp")
local on_attach = utils_lsp.on_attach
local capabilities = utils_lsp.capabilities

-- diagnostic setup
local diagnostics = require("utils.diagnostics")
diagnostics.setup()

-- on_attach and capabilities for all servers
-- for _, server in ipairs(servers) do
--     vim.lsp.config(server, {
    --     on_attach = on_attach,
    --     capabilities = capabilities,
    --     })
-- end

-- on attach function
local group = vim.api.nvim_create_augroup("LspMappings", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
	group = group,
	callback = on_attach,
})

-- capabilitites for servers
vim.lsp.config("*", { capabilities = capabilities, })

-- enable servers
vim.lsp.enable(servers)
print(servers)
