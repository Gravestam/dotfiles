return {
	"rmagatti/auto-session",
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			auto_restore_enabled = false,
			auto_session_suppress_dirs = { "~/", "~/Downloads", "~/Documents/", "/tmp" },
		})

		local keymap = vim.keymap

		keymap.set("n", "<leader>ss", "<cmd>SessionSave<CR>", { desc = '[S]ession [S]ave' })
		keymap.set("n", "<leader>sr", "<cmd>SessionRestore<CR>", { desc = '[S]ession [R]estore' })
	end,
}
