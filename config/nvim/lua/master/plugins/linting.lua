return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		-- lint.linters_by_ft = {
		-- 	javascript = { "eslint" },
		-- 	typescript = { "eslint" },
		-- 	svelte = { "eslint" },
		-- 	python = { "pylint" },
		-- }

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		local keymap = vim.keymap

		keymap.set("n", "<leader>l", lint.try_lint, { desc = "Trigger linting for current file" })
	end,
}
