
return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        'nvim-tree/nvim-web-devicons'
    },
    config = function()

        local telescope = require('telescope')
        local actions = require('telescope.actions')

        telescope.setup({
            defaults = {
                path_display = { 'smart' }, -- paths will be truncated
                mappings = {
                    i = {
                        [ '<C-up>' ] = actions.move_selection_previous,
                        [ '<C-down>' ] = actions.move_selection_next
                    }
                }
            }
        })

        telescope.load_extension('fzf')

        local keymap = vim.keymap

        keymap.set('n', '<leader>sf', '<cmd>Telescope find_files<CR>', { desc = 'Telescope [s]earch [f]iles in cwd' } )
        keymap.set('n', '<leader>sr', '<cmd>Telescope oldfiles<CR>', { desc = 'Telescope [s]earch [r]ecent files' } )
        keymap.set('n', '<leader>ss', '<cmd>Telescope live_grep<CR>', { desc = 'Telescope [s]earch [s]tring in cwd' } )
        keymap.set('n', '<leader>sc', '<cmd>Telescope grep_string<CR>', { desc = 'Telescope [s]earch [c]ursor in cwd' } )
    end
}
