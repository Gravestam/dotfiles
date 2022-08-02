local lsp_installer = require('nvim-lsp-installer')

local opts = { noremap = true, silent = true }

local on_attach = function(client, bufnr)

	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local servers = {
	'pyright',
	'tsserver',
	'bashls',
	'sumneko_lua',
	'jsonls',
	'html',
	'cssls'
}

for _, name in pairs(servers) do

	local server_found, server = lsp_installer.get_server(name)

	if server_found then
		if not server:is_installed() then
			print('Installing ' .. name)
			server:install()
		end
	end
end

lsp_installer.on_server_ready(function(server)

	local default_options = {
		on_attach = on_attach,
		capabilities = capabilities
	}

	server:setup(default_options)
end)
