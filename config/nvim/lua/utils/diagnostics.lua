local M = {}

local diagnostic_signs = {
	Error = "",
	Warn = "",
	Hint = "",
	Info = "",
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
				[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
				[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
				[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
				[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
			},
		},
	})
end

return M
