
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(function(use)

	-- packaer can manage itself
	use 'wbthomason/packer.nvim'

	-- Plugins
	use 'kyazdani42/nvim-web-devicons'								-- icon support for plugins
	use 'kyazdani42/nvim-tree.lua'									-- file explorer
	use 'neovim/nvim-lspconfig'										-- language server protocol
	use 'williamboman/nvim-lsp-installer'							-- language server installer
	use 'hrsh7th/nvim-cmp' 											-- Autocompletion plugin
	use 'hrsh7th/cmp-nvim-lsp'										-- LSP source for nvim-cmp
	use 'saadparwaiz1/cmp_luasnip'									-- Snippets source for nvim-cmp
	use 'L3MON4D3/LuaSnip'											-- Snippets plugin
	use 'onsails/lspkind.nvim'										-- cmp icons
	use 'rcarriga/nvim-notify'										-- notification manager
	use 'nvim-lualine/lualine.nvim'									-- statusline
	use 'romgrk/barbar.nvim'										-- buffer tabs
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }	-- syntax highlighting
	use 'nvim-treesitter/nvim-treesitter-refactor'					-- highlighting and renaming
	use 'nvim-lua/plenary.nvim'										-- telescope dependency
	use 'nvim-telescope/telescope.nvim'								-- fuzzy finder popup
	use 'jose-elias-alvarez/null-ls.nvim'							-- post action hooks (format on save etc)

	-- colorschemes
	use 'Mofiqul/dracula.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
