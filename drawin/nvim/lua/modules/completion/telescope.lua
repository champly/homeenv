require('telescope').setup {
	defaults = {
		prompt_prefix = '🔭 ',
		selection_caret = " ",
		sorting_strategy = 'ascending',
		layout_strategy = "horizontal",
		winblend = 30,
		layout_config = {
			prompt_position = 'top',
			height = 0.8,
			width = 0.8,
		},
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		}
	}
}

require('telescope').load_extension('fzy_native')
require('telescope').load_extension('gosource')
require('telescope').load_extension('dotfiles')
