
require('nvim-treesitter.configs').setup {

	ensure_installed = {
		'bash',
		'css',
		'javascript',
		'html',
		'json',
		'lua',
		'markdown',
		'regex',
		'scss',
		'toml',
		'vim',
		'yaml'
	},
	sync_install = false,
	auto_install = true,
	ignore_install = {},

	highlight = {
		enable = true,
		disable = {},
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},

	refactor = {
		highlight_definitions = {
			enable = true,
			clear_on_cursor_move = true
		},
		smart_rename = {
			enable = true,
			keymaps = {
				smart_rename = 'grr';
			}
		},
		navigation = {
			enable = true,
			keymaps = {
				goto_definition = 'gd',
				goto_next_usage = '<a-n>',
				goto_previous_usage = '<a-p>'
			}
		}
	}
}
