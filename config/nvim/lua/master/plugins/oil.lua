return {
	'stevearc/oil.nvim',
	opts = {},
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local oil = require('oil')

		oil.setup({
			default_file_explorer = false,
			skip_confirm_for_simple_edits = true,
			prompt_save_on_select_new_entry = true,
			columns = {
				"icon",
				"permissions",
				"size",
			},
		})

		local keymap = vim.keymap

		keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
}
