-- change the default file exporer to tree
vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt
local global = vim.g

opt.showmode = false -- do not show insert|virual|normal etc, this is reduntant because of lualine

opt.relativenumber = true -- set numbers to appear in the gutter
opt.number = true -- show the actual line number where the cursor is

opt.cursorline = true -- highlights the line where the cursor is

opt.scrolloff = 10 -- keep n lines above and below the cursor when scrolling

opt.tabstop = 4 -- n spaces for tabs
opt.shiftwidth = 4 -- n spaces for indent width
opt.expandtab = false -- keep using tabs
opt.autoindent = true -- copy indent from current line when starting new one

-- opt.list = true -- show listchars
-- opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- custom characters for listchar representation

opt.timeout = true -- enable timeout
opt.timeoutlen = 500 -- timeout length in milliseconds (will affect plugins like which-key)

opt.wrap = false -- disable linewrapping

opt.ignorecase = true -- make search case insensitive
opt.smartcase = true -- make search case sensitive if we type with mixed case

opt.termguicolors = true -- allow nvim to take advantage of all colors in the terminal emulator
opt.background = "dark" -- prefers dark mode in a given colorscheme, if it has one
opt.signcolumn = "yes" -- always show the sign column, this is to prevent shifting of text

opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line, insert mode start position

opt.clipboard:append("unnamedplus") -- use system clipboaard as default register

opt.splitright = true -- split vertical windows to the right
opt.splitbelow = true -- split horizontal windows to the bottom

opt.undofile = true -- save undo history to a file

global.have_nerd_fonts = true -- enable nerd fonts
