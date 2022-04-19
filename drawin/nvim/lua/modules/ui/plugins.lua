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
-- ui["goolord/alpha-nvim"] = {
--     config = conf.alpha_nvim,
--     requires = "kyazdani42/nvim-web-devicons",
-- }

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

-- use with nvim-lspconfig
-- git-blame virtual text
-- ui["f-person/git-blame.nvim"] = {
--     config = function()
--         -- relative date
--         vim.g.gitblame_date_format = "%r"
--         vim.g.gitblame_message_template = "     (<author> <date>) <summary>"
--     end
-- }

ui["lewis6991/gitsigns.nvim"] = {
	event = "BufReadPre",
	disable = not completion_with_lsp,
	config = conf.gitsigns_nvim,
}

-- float terminal
-- ui["akinsho/toggleterm.nvim"]
ui["voldikss/vim-floaterm"] = {
	config = conf.vim_floaterm,
}

-- notify
ui["rcarriga/nvim-notify"] = {
	config = conf.nvim_notify,
}

-- ui["danilamihailov/beacon.nvim"] = {
--     config = conf.beacon,
-- }

-- ui["folke/which-key.nvim"] = {
--     config = conf.which_key,
-- }

return ui
