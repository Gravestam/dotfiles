
return {
    'folke/tokyonight.nvim',
    priority = 1000, -- make sure this loads asap...
    config = function()

        require('tokyonight').setup({
            style = 'night'
        })

        vim.cmd('colorscheme tokyonight')
    end
}
