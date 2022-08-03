
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
keymap('n', '<leader>j', '<C-w>h', options)
keymap('n', '<leader>k', '<C-w>l', options)

-- buffer navigation
keymap('n', '<leader>,', ':bnext<Cr>', options)
keymap('n', '<leader>m', ':bprevious<Cr>', options)

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
keymap('n', '<leader>fb', ':Telescope buffers<CR>', options)
keymap('n', '<leader>fh', ':Telescope oldfiles<CR>', options)

-- terminal
keymap('n', '<leader>;', ':lua NTGlobal["terminal"]:toggle()<cr>', options)
