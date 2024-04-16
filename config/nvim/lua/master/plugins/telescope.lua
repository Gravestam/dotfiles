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

		keymap.set("n", "<leader>sf", tsb.find_files, { desc = "Telescope [s]earch [f]iles in cwd" })
		keymap.set("n", "<leader>sr", tsb.oldfiles, { desc = "Telescope [s]earch [r]ecent files" })
		keymap.set("n", "<leader>ss", tsb.live_grep, { desc = "Telescope [s]earch [s]tring in cwd" })
		keymap.set("n", "<leader>sc", tsb.grep_string, { desc = "Telescope [s]earch [c]ursor in cwd" })
		keymap.set("n", "<leader>sb", tsb.buffers, { desc = "Telescope [s]earch [b]uffers" })
		keymap.set("n", "<leader>sk", tsb.keymaps, { desc = "Telescope [s]earch [k]eymaps" })

		keymap.set("n", "<leader>/", function()
			tsb.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
				layout_config = { width = 0.65, height = 0.5 },
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })
	end,
}
