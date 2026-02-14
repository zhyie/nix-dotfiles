-- local servers = { "lua_ls", "nixd", "clangd", }
local servers = require("servers").servers

local lsp = require("utils.lsp")
local on_attach = lsp.on_attach
local capabilities = lsp.capabilities

-- diagnostic setup
local diagnostic = require("utils.diagnostic")
diagnostic.setup()

-- on attach function
local group = vim.api.nvim_create_augroup("LspMappings", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
	group = group,
	callback = on_attach,
})

-- capabilities for all servers
-- for _, server in ipairs(servers) do
--     vim.lsp.config(server, { capabilities = capabilities, })
-- end

-- capabilitites for servers
vim.lsp.config("*", { capabilities = capabilities, })

-- enable servers
vim.lsp.enable(servers)
