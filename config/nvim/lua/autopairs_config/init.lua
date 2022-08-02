
local status_ok, a_pairs = pcall(require, 'nvim-autopairs')

if not status_ok then
	return
end

a_pairs.setup({
	check_ts = true,
	enable_check_bracket_line = true,
})
