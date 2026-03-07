local M = {}

local signs = {
	Error = "",
	Warn = "",
	Hint = "",
	Info = "",
}

function M.setup()
	vim.diagnostic.config({
        virtual_text = true,
        severity_sort = true,
        float = {
            style = "minimal",
            border = "rounded",
            source = "if_many",
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

function M.keymap()

end

return M
