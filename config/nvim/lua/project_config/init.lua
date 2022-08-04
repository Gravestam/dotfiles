
local status_ok, p = pcall(require, 'project_nvim')

if not status_ok then
	return
end

require('telescope').load_extension('projects')

p.setup {}
