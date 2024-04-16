
return {
    'smoka7/hop.nvim',
    version = '*',
    opts = {},
    config = function()
      require('hop').setup {
        vim.keymap.set('n', '<leader><leader>/', require('hop').hint_patterns, { desc = '[/] Patterns' }),
        vim.keymap.set('n', '<leader><leader>a', require('hop').hint_anywhere, { desc = '[A]nywhere' }),
        vim.keymap.set('n', '<leader><leader>w', require('hop').hint_words, { desc = '[W]ords' }),
        vim.keymap.set('n', '<leader><leader>l', require('hop').hint_lines, { desc = '[L]ines' }),
      }
    end,
}
