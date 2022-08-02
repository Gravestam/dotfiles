local alpha_ok, alpha = pcall(require, 'alpha')

if not alpha_ok then
	return
end

local dashboard = require('alpha.themes.dashboard')

dashboard.section.header.val = {
	[[                -@                ]],
    [[               .##@               ]],
    [[              .####@              ]],
    [[              @#####@             ]],
    [[            . *######@            ]],
    [[           .##@o@#####@           ]],
    [[          /############@          ]],
    [[         /##############@      NeoVIM   ]],
    [[        @######@**%######@        ]],
    [[       @######`     %#####o       ]],
    [[      @######@       ######%      ]],
    [[    -@#######h       ######@.`    ]],
    [[   /#####h**``       `**%@####@   ]],
    [[  @H@*`                    `*%#@  ]],
    [[ *`          Gravestam         `* ]]
}

dashboard.section.buttons.val = {
	dashboard.button('f', ' ' .. '   Find File', ':Telescope find_files <CR>'),
	dashboard.button('e', ' ' .. '   New File', ':ene <BAR> startinsert <CR>'),
	dashboard.button('r', ' ' .. '   Recent Files', ':Telescope oldfiles <CR>'),
	dashboard.button('t', ' ' .. '   Find Text (live grep)', ':Telescope live_grep <CR>'),
	dashboard.button('c', ' ' .. '   Config', ':e ~/.config/nvim/init.lua <CR>'),
	dashboard.button('q', ' ' .. '   Exit vim ', ':qa <CR>')
}

local function footer()
	return 'Sup Bitches!'
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = 'Type'
dashboard.section.header.opts.hl = 'Include'
dashboard.section.buttons.opts.hl = 'Keyword'

dashboard.opts.opts.noautocmd = true

alpha.setup(dashboard.opts)
