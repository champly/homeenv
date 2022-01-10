local ui = {}
local conf = require("modules.ui.config")

-- theme
-- use 'tomasiser/vim-code-dark'
-- use 'rakr/vim-one'
-- use 'rktjmp/lush.nvim'
-- use 'npxbr/gruvbox.nvim'
ui["morhetz/gruvbox"] = {
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
	config = conf.bufferline,
	requires = "kyazdani42/nvim-web-devicons",
}

ui["glepnir/galaxyline.nvim"] = {
	branch = "main",
	config = conf.galaxyline,
}

-- Git
-- use 'tpope/vim-fugitive'
ui["airblade/vim-gitgutter"] = {
	config = conf.vim_gitgutter,
}

-- float terminal
ui["voldikss/vim-floaterm"] = {
	config = conf.vim_floaterm,
}

-- notify
ui["rcarriga/nvim-notify"] = {
	config = conf.nvim_notify,
}

return ui
