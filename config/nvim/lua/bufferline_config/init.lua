
local status_ok, bufferline = pcall(require, 'bufferline')

if not status_ok then
	return
end

local nvim_tree_events = require('nvim-tree.events')
local bufferline_state = require('bufferline.state')

local function get_tree_size()
  return vim.api.nvim_win_get_width(0)
end
nvim_tree_events.on_tree_open(function()
  bufferline_state.set_offset(get_tree_size())
end)

nvim_tree_events.on_tree_resize(function()
  bufferline_state.set_offset(get_tree_size())
end)

nvim_tree_events.on_tree_close(function()
  bufferline_state.set_offset(0)
end)

bufferline.setup {
	animation = true,
	auto_hide = false,
	tabpages = true,
	closable = false,
	clickable = true,
	icons = true,
	icon_separator_active = '▎',
	icon_separator_inactive = '',
	icon_close_tab = '',
	icon_close_tab_modified = '●',
	icon_pinned = '車',
	insert_at_end = true,
	semantic_letters = true
}
