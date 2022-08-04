
local status_ok, col = pcall(require, 'colorizer')

if not status_ok then
	return
end

col.setup()
