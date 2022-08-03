
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

local packer_ok, packer = pcall(require, 'packer')

if not packer_ok then
	return
end

vim.cmd [[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]]

packer.init {
	display = {
		open_fn = function ()
			return require('packer.util').float { border = 'rounded'}
		end
	}
}

return packer.startup(function(use)

	-- packaer can manage itself
	use 'wbthomason/packer.nvim'

	-- Plugins
	use 'kyazdani42/nvim-web-devicons'								-- icon support for plugins
	use 'kyazdani42/nvim-tree.lua'									-- file explorer
	use 'neovim/nvim-lspconfig'										-- language server protocol
	use 'williamboman/nvim-lsp-installer'							-- language server installer
	use 'hrsh7th/nvim-cmp' 											-- Autocompletion plugin
	use 'hrsh7th/cmp-nvim-lsp'										-- LSP source for nvim-cmp
	use 'hrsh7th/cmp-buffer'										-- buffer completions
	use 'hrsh7th/cmp-path' 											-- path completions
	use 'saadparwaiz1/cmp_luasnip'									-- Snippets source for nvim-cmp
	use 'L3MON4D3/LuaSnip'											-- Snippets plugin
	use 'onsails/lspkind.nvim'										-- cmp icons
	use 'nvim-lualine/lualine.nvim'									-- statusline
	use 'romgrk/barbar.nvim'										-- buffer tabs
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }	-- syntax highlighting
	use 'nvim-treesitter/nvim-treesitter-refactor'					-- highlighting and renaming
	use 'nvim-lua/plenary.nvim'										-- telescope dependency
	use 'nvim-telescope/telescope.nvim'								-- fuzzy finder popup
	use 'jose-elias-alvarez/null-ls.nvim'							-- post action hooks (format on save etc)
	use 'numToStr/Comment.nvim'										-- commenting lines
	use 'windwp/nvim-autopairs'										-- automatic pair insertion
	use 'rafamadriz/friendly-snippets'								-- snippets for several languages
	use 'goolord/alpha-nvim'										-- dashboard
	use 'mg979/vim-visual-multi'									-- multi cursor support

	-- colorschemes
	use 'Mofiqul/dracula.nvim'

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
