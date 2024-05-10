return {
	"theprimeagen/harpoon",
	event = "VimEnter",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		harpoon.setup({
			global_settings = {
				save_on_toggle = false,
				save_on_change = true,
				mark_branch = true,
			},
		})

		local keymap = vim.keymap

		keymap.set(
			"n",
			"<leader>ht",
			'<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>',
			{ desc = "[H]arpoon [T]oggle UI" }
		)
		keymap.set("n", "<leader>ha", '<cmd>lua require("harpoon.mark").add_file()<CR>', { desc = "[H]arpoon [A]dd mark" })
		keymap.set("n", "<leader>hn", '<cmd>lua require("harpoon.ui").nav_next()<CR>', { desc = "[H]arpoon go to [N]ext" })
		keymap.set("n", "<leader>hp", '<cmd>lua require("harpoon.ui").nav_prev()<CR>', { desc = "[H]arpoon go to [P]revious" })
	end,
}
