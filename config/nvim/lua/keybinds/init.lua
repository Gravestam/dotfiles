
local keymap = vim.keymap.set
local options = { silent = true }

-- space as leader
keymap('', '<Space>', '<Nop>', options)
vim.g.mapleader = ' '
vim.g.maplocalleader = ''

-- modes
-- n = normal
-- i = insert
-- v = visual
-- x = visual block
-- t = term
-- c = command

-- window navigation
keymap('n', '<C-Up>', '<C-w>k', options)
keymap('n', '<C-Down>', '<C-w>j', options)
keymap('n', '<C-Left>', '<C-w>h', options)
keymap('n', '<C-Right>', '<C-w>l', options)

-- buffer navigation
keymap('n', '<S-Right>', ':bnext<Cr>', options)
keymap('n', '<S-Left>', ':bprevious<Cr>', options)

-- close buffer
keymap('n', '<S-q>', '<cmd>bdelete!<Cr>', options)

-- clear highlights
keymap('n', '<leader>h', '<cmd>nohlsearch<Cr>', options)

-- easier indent
keymap('n', '>', '>>', options)
keymap('n', '<', '<<', options)

-- tree
keymap('n', '<leader>e', ':NvimTreeToggle<CR>', options)

-- telescope
keymap('n', '<leader>ff', ':Telescope find_files<CR>', options)
keymap('n', '<leader>ft', ':Telescope live_grep<CR>', options)
keymap('n', '<leader>fp', ':Telescope projects<CR>', options)
keymap('n', '<leader>fb', ':Telescope buffers<CR>', options)
