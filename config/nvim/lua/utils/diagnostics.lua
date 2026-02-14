local M = {}

local signs = {
	Error = "",
	Warn = "",
	Hint = "",
	Info = "",
}

M.setup = function()
	vim.diagnostic.config({
        virtual_text = true,
        severity_sort = true,
        float = {
            style = "minimal",
            border = "rounded",
            source = "if_many"
            header = "",
            prefix = "",
        },
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = signs.Error,
				[vim.diagnostic.severity.WARN] = signs.Warn,
				[vim.diagnostic.severity.INFO] = signs.Info,
				[vim.diagnostic.severity.HINT] = signs.Hint,
			},
		},
	})
end

return M
