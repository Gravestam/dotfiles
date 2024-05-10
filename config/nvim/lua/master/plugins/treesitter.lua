return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			highlight = { enable = true },
			auto_install = true,
			indent = { enable = true },
			autotag = { enable = true },
			ensure_installed = {
				"json",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"html",
				"css",
				"markdown",
				"markdown_inline",
				"svelte",
				"bash",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
				"vimdoc",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_oncremental = false,
					node_decremental = "<bs>",
				},
			},
		})
		
		-- SETUP TREESITTER FOR FOLDS
		local options = vim.opt

		options.foldcolumn = "0"
		options.foldmethod = "expr"
		options.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		options.foldtext = ""

		options.foldnestmax = 3
		options.foldlevel = 99
		options.foldlevelstart = 99
	end,
}
