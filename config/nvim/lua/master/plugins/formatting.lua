return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		local formatOptions = {
			lsp_fallback = true,
			async = false,
			timeout_ms = 1000,
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
			format_on_save = formatOptions,
		})

		local keymap = vim.keymap

		keymap.set({ "n", "v" }, "<leader>cf", function()
			conform.format(formatOptions)
		end, { desc = "[c]hange [f]ormat using conform" })
	end,
}