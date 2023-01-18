local package = require("core.pack").package
local conf = require("modules.ui.config")

-- theme
-- use "tomasiser/vim-code-dark"
-- use "rakr/vim-one"
-- use "rktjmp/lush.nvim"
-- ui["morhetz/gruvbox"] = {
--     config = conf.gruvbox,
-- }
package({
	"ellisonleao/gruvbox.nvim",
	config = conf.gruvbox
})

-- This plugin provides a start screen
-- use "mhinz/vim-startify"
package({
	"glepnir/dashboard-nvim",
	config = conf.dashboard,
})

-- file system explorer
package({
	"kyazdani42/nvim-tree.lua",
	dependencies = "kyazdani42/nvim-web-devicons",
	config = conf.nvim_tree,
})

-- Lean & mean status/tabline for vim that's light as air.
-- use "vim-airline/vim-airline"
-- use "vim-airline/vim-airline-themes"
-- use <leader>fb replace
package({
	"akinsho/bufferline.nvim",
	event = "BufReadPre",
	config = conf.bufferline,
})

-- use 'nvim-lualine/lualine.nvim'
package({
	"feline-nvim/feline.nvim",
	dependencies = "kyazdani42/nvim-web-devicons",
	enabled = vim.g.completion_with_lsp,
	config = conf.feline_nvim,
})
-- ui["windwp/windline.nvim"] = {}
package({
	"glepnir/galaxyline.nvim",
	branch = "main",
	enabled = not vim.g.completion_with_lsp,
	config = conf.galaxyline,
})

-- Git
-- use 'tpope/vim-fugitive'
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
-- ui["akinsho/toggleterm.nvim"]
package({
	"voldikss/vim-floaterm",
	event = "BufRead",
	config = conf.vim_floaterm,
})

-- notify
package({
	"rcarriga/nvim-notify",
	config = conf.nvim_notify,
})

-- -- parentheses improved
-- ui["luochen1990/rainbow"] = {
--     event = "BufRead",
--     config = conf.rainbow,
-- }

-- ui["p00f/nvim-ts-rainbow"] = {
--     after = "nvim-treesitter",
--     config = conf.nvim_ts_rainbow
-- }

-- ui["danilamihailov/beacon.nvim"] = {
--     config = conf.beacon,
-- }

-- ui["folke/which-key.nvim"] = {
--     config = conf.which_key,
-- }
