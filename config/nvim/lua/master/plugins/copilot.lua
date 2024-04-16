
return {
  {
    'zbirenbaum/copilot.lua',
    event = 'VimEnter',
    config = function()
      require('copilot').setup {
        panel = { enabled = false }, -- This is set to false due to copilot cmp
        suggestion = { enabled = false }, -- This is set to false due to copilot cmp
        layout = { position = 'bottom' } -- top, left right
      }
    end
  },
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup()
    end
  }
}
