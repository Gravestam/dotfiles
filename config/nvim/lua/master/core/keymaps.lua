local keymap = vim.keymap
local global = vim.g

global.mapleader = " " -- set <leader> to space
global.maplocalleader = " " -- set <localleader> to space

keymap.set("n", "<leader>nh", "<cmd>nohl<CR>", { desc = "Clear [H]ighlights" })

-- navigation
keymap.set("n", "<C-e>", "<C-d>", { desc = "Move half page down" })

-- windows
keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split [W]indow [V]ertically" })
keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split [W]indow [H]orizontally" })
keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make [W]indows [E]qual size" })
keymap.set("n", "<leader>wc", "<cmd>close<CR>", { desc = "[W]indow [C]lose" })

-- tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "New [T]ab [O]pen" })
keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "[T]ab [C]lose" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "[T]ab [N]ext" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "[T]ab [P]revious" })
keymap.set("n", "<leader>tb", "<cmd>tabnew %<CR>", { desc = "Open [T]ab with the current [B]uffer" })

keymap.set("n", "<C-right>", "<cmd>tabnext<CR>", { desc = "Next tab" })
keymap.set("n", "<C-left>", "<cmd>tabprevious<CR>", { desc = "Previous tab" })

-- intdentation
keymap.set("n", "<leader><leader>i", "gg=G<C-o>", { desc = "Auto [I]ndent" })
