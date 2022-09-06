
local keymap = vim.keymap.set
local options = { silent = true }

-- space as leader
keymap('', '<Space>', '<Nop>', options)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- modes
-- n = normal
-- i = insert
-- v = visual
-- x = visual block
-- t = term
-- c = command

-- window navigation
keymap('n', '<leader>h', '<C-w>h', options)
keymap('n', '<leader>,', '<C-w>l', options)

-- buffer navigation
keymap('n', '<leader>e', ':bnext<Cr>', options)
keymap('n', '<leader>n', ':bprevious<Cr>', options)
keymap('n', '<leader>k', ':BufferPick<Cr>', options)

-- close buffer
keymap('n', '<S-q>', '<cmd>bdelete!<Cr>', options)

-- clear highlights
keymap('n', '<leader>h', '<cmd>nohlsearch<Cr>', options)

-- easier indent
keymap('n', '>', '>>', options)
keymap('n', '<', '<<', options)

-- tree
keymap('n', '<leader><Tab>', ':NvimTreeToggle<Cr>', options)

-- telescope
keymap('n', '<leader>ff', ':Telescope find_files<Cr>', options)
keymap('n', '<leader>ft', ':Telescope live_grep<Cr>', options)
keymap('n', '<leader>fb', ':Telescope buffers<Cr>', options)
keymap('n', '<leader>fh', ':Telescope oldfiles<Cr>', options)
keymap('n', '<leader>fp', ':Telescope projects<Cr>', options)
keymap('n', '<leader>fr', ':Telescope registers<Cr>', options)

-- taglist
keymap('n', '<leader>t', ':SymbolsOutline<Cr>', options)

-- move lines
keymap('n', '<A-Down>', ':move +1<Cr>')
keymap('n', '<A-Up>', ':move -2<Cr>')

-- new lines
keymap('n', '<leader>o', 'o<Esc>')
keymap('n', '<leader>O', 'O<Esc>')
