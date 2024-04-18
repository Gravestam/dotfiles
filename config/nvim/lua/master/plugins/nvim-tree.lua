return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree docs
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		nvimtree.setup({
			view = { width = 35, relativenumber = true },
			renderer = {
				indent_markers = { enable = true },
				icons = {
					glyphs = {
						folder = { arrow_closed = "", arrow_open = "" },
					},
				},
			},
			actions = {
				open_file = {
					window_picker = { enable = false },
				},
			},
			filters = {
				custom = {},
			},
			git = { ignore = false },
		})

		local keymap = vim.keymap

		keymap.set("n", "<leader>et", "<cmd>NvimTreeToggle<CR>", { desc = "[E]xplorer [T]oggle" })
		keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "[E]xplorer current [F]ile" })
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "[E]xplorer [C]ollapse" })
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "[E]xplorer [R]efresh" })
	end,
}
