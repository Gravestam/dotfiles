
-- change the default file exporer to tree
vim.cmd('let g:netrw_liststyle = 3')

local opt = vim.opt

opt.relativenumber = true -- set numbers to appear in the gutter
opt.number = true -- show the actual line number where the cursor is

opt.cursorline = true -- highlights the line where the cursor is

opt.tabstop = 4 -- n spaces for tabs
opt.shiftwidth = 4 -- n spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

opt.wrap = false -- disable linewrapping

opt.ignorecase = true -- make search case insensitive
opt.smartcase = true -- make search case sensitive if we type with mixed case

opt.termguicolors = true -- allow nvim to take advantage of all colors in the terminal emulator
opt.background = 'dark' -- prefers dark mode in a given colorscheme, if it has one
opt.signcolumn = 'yes' -- always show the sign column, this is to prevent shifting of text

opt.backspace = 'indent,eol,start' -- allow backspace on indent, end of line, insert mode start position

opt.clipboard:append('unnamedplus') -- use system clipboaard as default register

opt.splitright = true -- split vertical windows to the right
opt.splitbelow = true -- split horizontal windows to the bottom
