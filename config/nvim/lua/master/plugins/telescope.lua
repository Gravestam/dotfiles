return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "smart" }, -- paths will be truncated
				mappings = {
					i = {
						["<C-up>"] = actions.move_selection_previous,
						["<C-down>"] = actions.move_selection_next,
					},
				},
			},
			extensions = {
				["ui_select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui_select")

		local keymap = vim.keymap
		local tsb = require("telescope.builtin")

		keymap.set("n", "<leader>ff", tsb.find_files, { desc = "Telescope [F]ind [F]iles in cwd" })
		keymap.set("n", "<leader>fr", tsb.oldfiles, { desc = "Telescope [F]ind [R]ecent files" })
		keymap.set("n", "<leader>fs", tsb.live_grep, { desc = "Telescope [F]ind [S]tring in cwd" })
		keymap.set("n", "<leader>fc", tsb.grep_string, { desc = "Telescope [F]ind [C]ursor in cwd" })
		keymap.set("n", "<leader>fb", tsb.buffers, { desc = "Telescope [F]ind [B]uffers" })
		keymap.set("n", "<leader>fk", tsb.keymaps, { desc = "Telescope [F]ind [K]eymaps" })

		keymap.set("n", "<leader>/", function()
			tsb.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
				layout_config = { width = 0.65, height = 0.5 },
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })

		keymap.set("n", "<leader>fn", function()
			tsb.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[F]ind [N]eovim files" })
	end,
}
