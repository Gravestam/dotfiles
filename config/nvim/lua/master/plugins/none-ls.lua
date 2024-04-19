return {
	"nvimtools/none-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua, -- Lua formatting

				null_ls.builtins.formatting.prettier, -- javascript, typescript, json, etc formatter
				require("none-ls.diagnostics.eslint_d"), -- javascript, typescript, etc linter

				null_ls.builtins.formatting.black, -- Python formatter
				require("none-ls.diagnostics.flake8"), -- Python linter

				null_ls.builtins.formatting.shfmt, -- Shell script formatter
			},
		})

		local keymap = vim.keymap

		keymap.set("n", "<leader><leader>f", vim.lsp.buf.format, { desc = "[F]ormat current file using none_ls" })
	end,
}
