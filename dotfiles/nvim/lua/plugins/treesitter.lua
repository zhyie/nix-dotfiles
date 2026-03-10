return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',

	config = function()
		local treesitter = require('nvim-treesitter')

		treesitter.config.setup {
			ensure_installed = { "nix", "c", "lua", "markdown", },
			auto_install = false,
			highlight = {
				enable = true,
				disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
								return true
						end
				end,
				additional_vim_regex_highlighting = false,
			},
		}
	end,
	--     local treesitter = require('nvim-treesitter')
	--     local filetypes = { 'lua', 'nix', 'c', },
	--
	--     treesitter.setup({})
	--     treesitter.install({ filetypes })
	--
	--     vim.api.nvim_create_autocmd('FileType', {
	--       pattern = { '*' },
	--       callback = function() vim.treesitter.start() end,
	--     })
}
