return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header.val = {
			"													   ",
			" ███╗   ███╗ █████╗ ███████╗████████╗███████╗██████╗  ",
			" ████╗ ████║██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗ ",
			" ██╔████╔██║███████║███████╗   ██║   █████╗  ██████╔╝ ",
			" ██║╚██╔╝██║██╔══██║╚════██║   ██║   ██╔══╝  ██╔══██╗ ",
			" ██║ ╚═╝ ██║██║  ██║███████║   ██║   ███████╗██║  ██║ ",
			" ╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝ ",
			"													   ",
		}

		dashboard.section.buttons.val = {
			-- dashboard.button("e", "    New File", "<cmd>ene<CR>"),
			-- dashboard.button("SPC et", "    Explorer", "<cmd>NvimTreeToggle<CR>"),
			-- dashboard.button("SPC sf", "    Search File", "<cmd>Telescope find_files<CR>"),
			-- dashboard.button("SPC ss", "    Search String", "<cmd>Telescope live_grep<CR>"),
		}

		alpha.setup(dashboard.opts)

		-- disable folding on alha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
