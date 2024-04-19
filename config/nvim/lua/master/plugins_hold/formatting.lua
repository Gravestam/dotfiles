return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		local formatOptions = {
			lsp_fallback = true,
			async = false,
			timeout_ms = 5000,
		}

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				svelte = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				less = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
			},
		})

		local keymap = vim.keymap

		keymap.set({ "n", "v" }, "<leader><leader>f", function()
			conform.format(formatOptions)
		end, { desc = "[F]ormat using conform" })
	end,
}
