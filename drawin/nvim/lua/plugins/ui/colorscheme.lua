return {
	{
		"ellisonleao/gruvbox.nvim",
		enabled = vim.g.color_theme == vim.g.color_theme_dark,
		config = function()
			require("gruvbox").setup({
				-- https://github.com/ellisonleao/gruvbox.nvim/issues/220
				italic = {
					strings = true,
					operators = true,
					comments = true,
				},
				overrides = {
					Operator = { link = "GruvboxFg1" },
				}
			})
			vim.o.background = "dark"
			vim.cmd([[ colorscheme gruvbox ]])
		end
	},
	{
		"projekt0n/github-nvim-theme",
		enabled = vim.g.color_theme == vim.g.color_theme_light,
		config = function()
			require("github-theme").setup({
				options = {
					styles = {
						comments = "italic",
					}
				}
			})
			vim.cmd([[ colorscheme github_light ]])
		end
	},
	{
		"akinsho/bufferline.nvim",
		event = "BufReadPre",
		config = function()
			-- https://github.com/akinsho/bufferline.nvim#configuration
			require("bufferline").setup {
				options = {
					numbers = function(opts)
						return string.format("%s.", opts.ordinal)
					end,
					modified_icon = "✥",
					buffer_close_icon = "",
					always_show_bufferline = false,
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							highlight = "Directory",
							separator = true -- use a "true" to enable the default, or set your own character
						}
					}
				}
			}

			local cmd = "nnoremap <silent><leader>%d <cmd>lua require('bufferline').go_to(%d, true)<cr>"
			for i = 1, 9, 1 do
				vim.cmd(string.format(cmd, i, i))
			end
		end,
	},
	-- {
	--     "nvim-lualine/lualine.nvim",
	--     dependencies = { "nvim-tree/nvim-web-devicons" },
	--     opts = {
	--         options = {
	--             theme = "onelight"
	--         }
	--     }
	-- },
	{
		"freddiehaddad/feline.nvim",
		event = "BufReadPre",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			if vim.g.color_theme == vim.g.color_theme_dark then
				vim.cmd [[ hi StatusLineNC guibg=#696157 gui=none ]]
			else
				vim.cmd [[ hi StatusLineNC guibg=#fce5cd gui=none ]]
			end
			require("plugins.ui.statusline.layout")
		end,
	}
}
