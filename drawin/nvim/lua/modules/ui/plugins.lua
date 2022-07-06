local ui = {}
local conf = require("modules.ui.config")

-- theme
-- use 'tomasiser/vim-code-dark'
-- use 'rakr/vim-one'
-- use 'rktjmp/lush.nvim'
-- ui["morhetz/gruvbox"] = {
--     config = conf.gruvbox,
-- }
ui["ellisonleao/gruvbox.nvim"] = {
	config = conf.gruvbox,
}

-- This plugin provides a start screen
-- use 'mhinz/vim-startify'
ui["glepnir/dashboard-nvim"] = {
	config = conf.dashboard,
}

-- file system explorer
ui["kyazdani42/nvim-tree.lua"] = {
	config = conf.nvim_tree,
	requires = "kyazdani42/nvim-web-devicons",
}

-- Lean & mean status/tabline for vim that's light as air.
-- use 'vim-airline/vim-airline'
-- use 'vim-airline/vim-airline-themes'
ui["akinsho/bufferline.nvim"] = {
	event = "BufReadPre",
	config = conf.bufferline,
	requires = "kyazdani42/nvim-web-devicons",
}

-- use 'nvim-lualine/lualine.nvim'
ui["feline-nvim/feline.nvim"] = {
	after = "nvim-web-devicons",
	disable = not completion_with_lsp,
	config = conf.feline_nvim,
}
-- ui["windwp/windline.nvim"] = {}

ui["glepnir/galaxyline.nvim"] = {
	branch = "main",
	disable = completion_with_lsp,
	config = conf.galaxyline,
}

-- Git
-- use 'tpope/vim-fugitive'
ui["airblade/vim-gitgutter"] = {
	disable = completion_with_lsp,
	config = conf.vim_gitgutter,
}

ui["lewis6991/gitsigns.nvim"] = {
	event = "BufReadPre",
	disable = not completion_with_lsp,
	config = conf.gitsigns_nvim,
}

-- float terminal
-- ui["akinsho/toggleterm.nvim"]
ui["voldikss/vim-floaterm"] = {
	event = "BufRead",
	config = conf.vim_floaterm,
}

-- notify
ui["rcarriga/nvim-notify"] = {
	config = conf.nvim_notify,
}

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

return ui
