local package = require("core.pack").package
local conf = require("modules.ui.config")

-- theme
-- package({"tomasiser/vim-code-dark"})
-- package({"rakr/vim-one"})
-- package({"rktjmp/lush.nvim"})
-- package({
--     "morhetz/gruvbox",
--     config = conf.gruvbox,
-- }
package({
	"ellisonleao/gruvbox.nvim",
	enabled = vim.g.color_theme == vim.g.color_theme_dark,
	config = conf.gruvbox
})
package({
	"projekt0n/github-nvim-theme",
	enabled = vim.g.color_theme == vim.g.color_theme_light,
	config = conf.github
})

package({
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	event = "BufRead",
	config = conf.telescope,
	dependencies = {
		{ "nvim-telescope/telescope-live-grep-args.nvim" },
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-fzy-native.nvim" },
		{ "nvim-lua/popup.nvim" },
	}
})

package({
	"kevinhwang91/nvim-bqf",
	ft = "qf",
	opts = {
		preview = {
			winblend = 0,
		}
	},
})

package({
	"stevearc/dressing.nvim",
	config = conf.dressing,
})

-- This plugin provides a start screen
-- package({"mhinz/vim-startify"})
package({
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = conf.dashboard,
})

-- file system explorer
package({
	"nvim-tree/nvim-tree.lua",
	keys = {
		"ff",
	},
	config = conf.nvim_tree,
})
-- TODO: replace nvim-tree with neo-tree
-- package({
--     "nvim-neo-tree/neo-tree.nvim",
--     branch = "v3.x",
--     cmd = "Neotree",
--     keys = {
--         "ff",
--     },
--     dependencies = {
--         "nvim-lua/plenary.nvim",
--         "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
--         "MunifTanjim/nui.nvim",
--     },
--     config = conf.neo_tree,
-- })

-- Lean & mean status/tabline for vim that's light as air.
-- package({"vim-airline/vim-airline"})
-- package({"vim-airline/vim-airline-themes"})
-- use <leader>fb replace
package({
	"akinsho/bufferline.nvim",
	event = "BufReadPre",
	config = conf.bufferline,
})

-- package({"nvim-lualine/lualine.nvim"})
package({
	"freddiehaddad/feline.nvim",
	event = "BufReadPre",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = conf.feline_nvim,
})

-- Git
-- package({"tpope/vim-fugitive"})
package({
	"lewis6991/gitsigns.nvim",
	event = "BufReadPre",
	config = conf.gitsigns_nvim,
})

-- float terminal
package({
	"akinsho/toggleterm.nvim",
	version = "*",
	cmd = { "ToggleTerm" },
	init = function()
		vim.api.nvim_set_keymap("n", "<F3>", ":ToggleTerm<CR>", { noremap = true })
	end,
	config = conf.toggleterm
})

-- notify
package({
	"rcarriga/nvim-notify",
	config = conf.nvim_notify,
})

package({
	"j-hui/fidget.nvim",
	opts = {
		progress = {
			display = {
				-- How long a message should persist after completion
				done_ttl = 1,
				-- https://github.com/j-hui/fidget.nvim/blob/main/lua/fidget/spinner/patterns.lua
				progress_icon = {
					pattern = "meter",
					period = 1,
				}
			}
		},
		notification = {
			window = {
				-- Background color opacity in the notification window
				winblend = 20,
			}
		}
	},
})

-- Active indent guide and indent text objects. When you're browsing
-- code, this highlights the current level of indentation, and animates
-- the highlighting.
package({
	"echasnovski/mini.indentscope",
	opts = {
		draw = {
			animation = function(s, n)
				return 5
			end,
		},
		options = {
			try_as_border = true,
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"help",
				"alpha",
				"dashboard",
				"neo-tree",
				"Trouble",
				"trouble",
				"lazy",
				"mason",
				"notify",
				"toggleterm",
				"lazyterm",
				"outline",
			},
			callback = function()
				---@diagnostic disable-next-line: inject-field
				vim.b.miniindentscope_disable = true
			end,
		})
	end,
})

-- package({
--     "folke/which-key.nvim",
--     config = conf.which_key,
-- })
