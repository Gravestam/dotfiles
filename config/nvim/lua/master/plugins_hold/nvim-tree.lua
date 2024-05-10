return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree docs
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- nvimtree.setup({
		-- 	view = { width = 35, relativenumber = true },
		-- 	renderer = {
		-- 		indent_markers = { enable = true },
		-- 		icons = {
		-- 			glyphs = {
		-- 				folder = { arrow_closed = "", arrow_open = "" },
		-- 			},
		-- 		},
		-- 	},
		-- 	actions = {
		-- 		open_file = {
		-- 			window_picker = { enable = false },
		-- 		},
		-- 	},
		-- 	filters = {
		-- 		custom = {},
		-- 	},
		-- 	git = { ignore = false },
		-- })

		local HEIGHT_RATIO = 0.8  -- You can change this
		local WIDTH_RATIO = 0.5   -- You can change this too

		nvimtree.setup({
			view = {
				float = {
					enable = true,
					open_win_config = function()
						local screen_w = vim.opt.columns:get()
						local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
						local window_w = screen_w * WIDTH_RATIO
						local window_h = screen_h * HEIGHT_RATIO
						local window_w_int = math.floor(window_w)
						local window_h_int = math.floor(window_h)
						local center_x = (screen_w - window_w) / 2
						local center_y = ((vim.opt.lines:get() - window_h) / 2)
						- vim.opt.cmdheight:get()
						return {
							border = 'rounded',
							relative = 'editor',
							row = center_y,
							col = center_x,
							width = window_w_int,
							height = window_h_int,
						}
					end,
				},
				width = function()
					return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
				end,
			},
		})
		local keymap = vim.keymap

		keymap.set("n", "<leader>et", "<cmd>NvimTreeToggle<CR>", { desc = "[E]xplorer [T]oggle" })
		keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "[E]xplorer current [F]ile" })
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "[E]xplorer [C]ollapse" })
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "[E]xplorer [R]efresh" })

		-- AUTO CLOSE NVIM TREE
		-- 1. Close the tab if nvim-tree is the last buffer in the tab (after closing a buffer)
		-- 2. Close vim if nvim-tree is the last buffer (after closing a buffer)
		-- 3. Close nvim-tree across all tabs when one nvim-tree buffer is manually closed if and only if tabs.sync.close is set.

		local function tab_win_closed(winnr)
			local api = require"nvim-tree.api"
			local tabnr = vim.api.nvim_win_get_tabpage(winnr)
			local bufnr = vim.api.nvim_win_get_buf(winnr)
			local buf_info = vim.fn.getbufinfo(bufnr)[1]
			local tab_wins = vim.tbl_filter(function(w) return w~=winnr end, vim.api.nvim_tabpage_list_wins(tabnr))
			local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
			if buf_info.name:match(".*NvimTree_%d*$") then            -- close buffer was nvim tree
				-- Close all nvim tree on :q
				if not vim.tbl_isempty(tab_bufs) then                      -- and was not the last window (not closed automatically by code below)
					api.tree.close()
				end
			else                                                      -- else closed buffer was normal buffer
				if #tab_bufs == 1 then                                    -- if there is only 1 buffer left in the tab
					local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
					if last_buf_info.name:match(".*NvimTree_%d*$") then       -- and that buffer is nvim tree
						vim.schedule(function ()
							if #vim.api.nvim_list_wins() == 1 then                -- if its the last buffer in vim
								vim.cmd "quit"                                        -- then close all of vim
							else                                                  -- else there are more tabs open
								vim.api.nvim_win_close(tab_wins[1], true)             -- then close only the tab
							end
						end)
					end
				end
			end
		end

		vim.api.nvim_create_autocmd("WinClosed", {
			callback = function ()
				local winnr = tonumber(vim.fn.expand("<amatch>"))
				vim.schedule_wrap(tab_win_closed(winnr))
			end,
			nested = true
		})
	end,
}
