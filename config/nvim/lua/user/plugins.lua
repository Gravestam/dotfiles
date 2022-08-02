
local fn = vim.fn

-- automatically installs packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system {
		'git',
		'clone',
		'--depth',
		'1',
		'https://github.com/wbthomason/packer.nvim',
	install_path
	}
	print 'Installing packer'
	vim.cmd [[packadd packer.nvim]]
end

-- automatically reloads nvim whenever we save in plugins.lua
vim.cmd [[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]]

-- use a protected call so we don't get error on first use
local status_ok, packer = pcall(require, 'packer')

if not status_ok then
	return
end

-- have packer use a popup window
packer.init {
	display = {
		open_fn = function()
			return require('packer.util').float { border = 'rounded' }
		end,
	},
}

-- Install plugins

return packer.startup(function(use)

	-- Plugins
	use 'wbthomason/packer.nvim'				-- have packer manage itself
	use 'nvim-lua/plenary.nvim'					-- lua functions used by plugins
	use 'windwp/nvim-autopairs'					-- autopairs, used with cmp and treesitter
	use 'nvim-lualine/lualine.nvim'				-- status line
	use 'akinsho/bufferline.nvim'				-- bufferline
	use 'nvim-treesitter/nvim-treesitter'
	use 'numToStr/Comment.nvim'					-- enables line commenting
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-vsnip'
	use 'hrsh7th/vim-vsnip'
	use 'kyazdani42/nvim-web-devicons'			-- filetree icon support
	use 'kyazdani42/nvim-tree.lua'				-- filetree
	use 'nvim-telescope/telescope.nvim'			-- fuzzyfinder, files, buffers
	use 'goolord/alpha-nvim'					-- greeter
	use 'RRethy/vim-illuminate'					-- highlights same values on cursor

	-- Colorschemes
	use 'lunarvim/darkplus.nvim'
	use 'Mofiqul/dracula.nvim'

	-- LSP
	use 'neovim/nvim-lspconfig'
	use 'williamboman/nvim-lsp-installer'


	-- automatically set up configuration after cloning packer.nvim
	-- this should always be last after all plugins
	if PACKER_BOOTSTRAP then
		require('packer').sync()
	end
end)
