
local status_ok, terminal = pcall(require, 'toggleterm')

if not status_ok then
	return
end

terminal.setup({
	size = 20,
	open_mapping = [[<C-;>]],
	hide_numbers = true,
	shade_terminal = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = 'horizontal',
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = 'single'
	}
})
