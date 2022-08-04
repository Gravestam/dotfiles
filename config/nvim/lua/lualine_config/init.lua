
local diagnostics = {
	'diagnostics',
	sources = { 'nvim_diagnostic' },
	symbols = { error = ' ', warn = ' ', info = ' ' },
	colored = true,
	always_visible = true
}

local fileformat = {
	'fileformat',
	fmt = string.upper,
	icons_enabled = false,
	color = { gui = 'bold' }
}

local diff = {
	'diff',
	symbols = { added = ' ', modified = '柳', removed = ' ' },
}

local filename = {
	'filename',
	color = { gui = 'bold' }
}

local branch = {
	'branch',
	icon = '',
	color = { gui = 'bold' }
}

local encoding = {
	'o:encoding',
	fmt = string.upper,
	color = { gui = 'bold' }
}

local lsp = {
	function()
		local msg = 'Disabled'
		local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return 'Enabled'
			end
		end
		return msg
	end,
	icon = ' LSP:',
	color = { gui = 'bold' },
}

require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'dracula-nvim',
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		disabled_filetypes = { 'alpha', 'NvimTree', 'toggleterm', 'Outline' },
		ignore_focus = {},
		always_divide_middle = false,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		}
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'progress', 'location', diagnostics },
		lualine_c = { filename },
		lualine_x = { lsp, 'filetype', encoding, fileformat },
		lualine_y = { branch, diff },
		lualine_z = {}
	},
	winbar = {},
	inactive_winbar = {},
	extensions = {}
}
