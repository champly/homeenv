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
	{
		"nvim-lualine/lualine.nvim",
		event = "BufReadPre",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			options = {
				theme = "onelight",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			-- +-------------------------------------------------+
			-- | A | B | C                             X | Y | Z |
			-- +-------------------------------------------------+
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diagnostics", },
				lualine_c = {
					{
						"filename",
						path = 1,
					},
					{
						"filetype",
						icon_only = true,
					},
				},
				lualine_x = {
					function()
						local clients = vim.lsp.get_clients()
						if next(clients) == nil then
							return ""
						end
						local client_names = {}
						for _, client in pairs(vim.lsp.get_clients()) do
							---@diagnostic disable-next-line: undefined-field
							table.insert(client_names, client.name)
						end
						return "  " .. table.concat(client_names, " ")
					end
				},
				lualine_y = { "diff", "searchcount" },
				lualine_z = { "progress" },
			}
		}
	}
}
