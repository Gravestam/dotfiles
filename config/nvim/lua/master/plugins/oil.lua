return {
	'stevearc/oil.nvim',
	opts = {},
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local oil = require('oil')

		oil.setup({
			default_file_explorer = true,
			skip_confirm_for_simple_edits = true,
			prompt_save_on_select_new_entry = true,
			columns = {
				"icon",
				"permissions",
				"size",
			},
			float = {
				padding = 2,
				max_width = 150,
				max_height = 75,
				border = "rounded",
				win_options = {
					winblend = 0,
				},
			},
		})

		local keymap = vim.keymap

		keymap.set("n", "_", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory (float)" })
	end,
}
