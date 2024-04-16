
return {
    'nvim-tree/nvim-tree.lua',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        local nvimtree = require('nvim-tree')

        -- recommended settings from nvim-tree docs
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        nvimtree.setup({
            view = { width = 35, relativenumber = true },
            renderer = {
                indent_markers = { enable = true },
                icons = {
                    glyphs = {
                        folder = { arrow_closed = '', arrow_open = '' }
                    }
                }
            },
            actions = {
                open_file = {
                    window_picker = { enable = false }
                }
            },
            filters = {
                custom = {}
            },
            git = { ignore = false }
        })

        local keymap = vim.keymap

        keymap.set('n', '<leader>et', '<cmd>NvimTreeToggle<CR>', { desc = '[e]xplorer [t]oggle' } )
        keymap.set('n', '<leader>ef', '<cmd>NvimTreeFindFileToggle<CR>', { desc = '[e]xplorer current [f]ile' } )
        keymap.set('n', '<leader>ec', '<cmd>NvimTreeCollapse<CR>', { desc = '[e]xplorer [c]ollapse' } )
        keymap.set('n', '<leader>er', '<cmd>NvimTreeRefresh<CR>', { desc = '[e]xplorer [r]efresh' } )
    end
}
