return {
	"brenoprata10/nvim-highlight-colors",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local colors = require("nvim-highlight-colors")

		colors.setup({
			render = "virtual",
			virtual_symbol = "■",
		})
	end,
}
