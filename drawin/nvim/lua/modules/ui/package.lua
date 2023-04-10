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
	config = conf.gruvbox
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
	"stevearc/dressing.nvim",
	config = conf.dressing,
})

-- This plugin provides a start screen
-- package({"mhinz/vim-startify"})
package({
	"glepnir/dashboard-nvim",
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
	"feline-nvim/feline.nvim",
	event = "BufReadPre",
	dependencies = "nvim-tree/nvim-web-devicons",
	enabled = vim.g.completion_with_lsp,
	config = conf.feline_nvim,
})
-- package({
--     "glepnir/whiskyline.nvim",
--     dependencies = { "nvim-tree/nvim-web-devicons" },
--     enabled = vim.g.completion_with_lsp,
--     config = conf.whiskyline,
-- })

-- package({"windwp/windline.nvim"})
package({
	"glepnir/galaxyline.nvim",
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

-- search and replace
package({
	"windwp/nvim-spectre",
	keys = {
		"<leader>S",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = conf.nvim_spectre
})

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
