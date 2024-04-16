local keymap = vim.keymap
local global = vim.g

global.mapleader = " " -- set <leader> to space
global.maplocalleader = " " -- set <localleader> to space

keymap.set("n", "<leader>nh", "<cmd>nohl<CR>", { desc = "Clear search highlights" })

-- windows
keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split [w]indow [v]ertically" })
keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split [w]indow [h]orizontally" })
keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make [w]indows [e]qual size" })
keymap.set("n", "<leader>wc", "<cmd>close<CR>", { desc = "[w]indow [c]lose" })

-- tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "New [t]ab [o]pen" })
keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "[t]ab [c]lose" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "[t]ab [n]ext" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "[t]ab [p]revious" })
keymap.set("n", "<leader>tb", "<cmd>tabnew %<CR>", { desc = "Open [t]ab with the current [b]uffer" })

keymap.set("n", "<C-right>", "<cmd>tabnext<CR>", { desc = "Next tab" })
keymap.set("n", "<C-left>", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
