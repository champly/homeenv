return {
	{
		"stevearc/dressing.nvim",
		opts = {
			input = {
				-- Set to false to disable the vim.ui.input implementation
				enabled = true,
				-- https://github.com/stevearc/dressing.nvim/issues/29#issuecomment-1076985525
				get_config = function()
					if vim.api.nvim_get_option_value("filetype", {}) == "NvimTree" then
						return { enabled = false }
					end
				end,
			},
			select = {
				enabled = true,
				get_config = function(opts)
					if opts.kind == "codeaction" then
						return {
							backend = "telescope",
							telescope = require("telescope.themes").get_cursor({}),
						}
					end
				end
			}
		}
	}
}
