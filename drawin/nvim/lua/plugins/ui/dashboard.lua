return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		if vim.g.color_theme == vim.g.color_theme_dark then
			vim.cmd [[ hi DashboardHeader guifg=yellow ]]
			vim.cmd [[ hi DashboardFooter guifg=gray ]]

			vim.cmd [[ hi DashboardIcon guifg=yellow ]]
			vim.cmd [[ hi DashboardDesc guifg=yellow ]]
			vim.cmd [[ hi DashboardShotCut guifg=#1E90FF ]]
			vim.cmd [[ hi DashboardKey guifg=#1E90FF ]]
		else
			vim.cmd [[ hi DashboardHeader guifg=orange ]]
			vim.cmd [[ hi DashboardFooter guifg=gray ]]

			vim.cmd [[ hi DashboardIcon guifg=orange ]]
			vim.cmd [[ hi DashboardDesc guifg=orange ]]
			vim.cmd [[ hi DashboardShotCut guifg=#1E90FF ]]
			vim.cmd [[ hi DashboardKey guifg=#1E90FF ]]
		end

		require("dashboard").setup({
			theme = "doom",
			config = {
				header = {
					"",
					"",
					"",
					"  ______         __                                      __     __           __            _                        __                             ",
					" /_  __/___     / /_  ___     ____  _____   ____  ____  / /_   / /_____     / /_  ___     (_)____   __  ______     / /_____     __  ______  __  __ ",
					"  / / / __ \\   / __ \\/ _ \\   / __ \\/ ___/  / __ \\/ __ \\/ __/  / __/ __ \\   / __ \\/ _ \\   / / ___/  / / / / __ \\   / __/ __ \\   / / / / __ \\/ / / / ",
					" / / / /_/ /  / /_/ /  __/  / /_/ / /     / / / / /_/ / /_   / /_/ /_/ /  / /_/ /  __/  / (__  )  / /_/ / /_/ /  / /_/ /_/ /  / /_/ / /_/ / /_/ /  ",
					"/_/  \\____/  /_.___/\\___/   \\____/_/     /_/ /_/\\____/\\__/   \\__/\\____/  /_.___/\\___/  /_/____/   \\__,_/ .___/   \\__/\\____/   \\__, /\\____/\\__,_/   ",
					"                                                                                                      /_/                    /____/                ",
					"",
					"",
					string.format(
						"v%s.%s.%s%s",
						vim.version().major,
						vim.version().minor,
						vim.version().patch,
						vim.version().api_prerelease and "-dev" or ""
					),
					"",
					"",
				},
				center = {
					{
						icon = "  ",
						desc = "Recently laset session                  ",
						key = "<leader>sl",
						action = [[ lua require("persistence").load() ]]
					},
					{
						icon = "  ",
						desc = "Recently opened files                   ",
						key = "<leader>fh",
						action = "Telescope oldfiles"
					},
					{
						icon = "  ",
						desc = "Find  File                              ",
						key = "<leader>ff",
						action = "Telescope find_files"
					},
					{
						icon = "  ",
						desc = "Find  word                              ",
						key = "<leader>fw",
						action = "Telescope live_grep"
					},
					{
						icon = "  ",
						desc = "Create new buffer                       ",
						key = "<leader> n",
						action = "enew"
					},
					{
						icon = "  ",
						desc = "Open Personal dotfiles                  ",
						key = "<leader>fd",
						action = "Telescope dotfiles"
					},
					{
						icon = "  ",
						desc = "Find Go Source Code                     ",
						key = "<leader>fs",
						action = "Telescope gosource"
					},
				},
				footer = {
					"",
					"",
					"If you think penguins are fat and waddle, you have never been attacked by one",
					"running at you in excess of 100 miles per hour.",
					"",
					"                                                            -- Linus Torvalds",
				}
			}
		})
	end,
}
