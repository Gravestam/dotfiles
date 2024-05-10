return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	config = function()

		local noice = require("noice")

		noice.setup({
			presets = {
				bottom_search = false,
				command_palette = false,
			},
			-- cmdline = { view = "cmdline" }, 
			routes = { -- enables the @recording message
				{
					view = "notify",
					filter = { event = "msg_showmode"}
				}
			}
		})
	end,
}
