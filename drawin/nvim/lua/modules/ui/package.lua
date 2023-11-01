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
	config = conf.nvim_bqf,
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
	-- "feline-nvim/feline.nvim",
	"freddiehaddad/feline.nvim",
	event = "BufReadPre",
	dependencies = "nvim-tree/nvim-web-devicons",
	enabled = vim.g.completion_with_lsp,
	config = conf.feline_nvim,
})
-- package({
--     "nvimdev/whiskyline.nvim",
--     dependencies = { "nvim-tree/nvim-web-devicons" },
--     enabled = vim.g.completion_with_lsp,
--     config = conf.whiskyline,
-- })

-- package({"windwp/windline.nvim"})
package({
	"nvimdev/galaxyline.nvim",
	branch = "main",
	enabled = not vim.g.completion_with_lsp,
	config = conf.galaxyline,
})

-- Git
-- package({"tpope/vim-fugitive"})
package({
	"airblade/vim-gitgutter",
	config = conf.vim_gitgutter,
	enabled = not vim.g.completion_with_lsp,
})

package({
	"lewis6991/gitsigns.nvim",
	event = "BufReadPre",
	enabled = vim.g.completion_with_lsp,
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
-- package({
--     "voldikss/vim-floaterm",
--     event = "BufRead",
--     cmd = { "FloatermToggle" },
--     config = conf.vim_floaterm,
-- })

-- notify
package({
	"rcarriga/nvim-notify",
	config = conf.nvim_notify,
})

-- -- indentiline
-- package({
--     "nvimdev/indentmini.nvim",
--     event = "BufEnter",
--     config = conf.indentmini,
-- })

-- parentheses improved
-- package({
--     "luochen1990/rainbow",
--     event = "BufRead",
--     config = conf.rainbow,
-- })

-- package({
--     "p00f/nvim-ts-rainbow",
--     dependencies = "nvim-treesitter",
--     config = conf.nvim_ts_rainbow
-- })

-- package({
--     "danilamihailov/beacon.nvim",
--     config = conf.beacon,
-- })

-- package({
--     "folke/which-key.nvim",
--     config = conf.which_key,
-- })
