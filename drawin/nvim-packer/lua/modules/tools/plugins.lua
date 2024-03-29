local tools = {}
local conf = require("modules.tools.config")

-- debug
tools["tweekmonster/startuptime.vim"] = {
	cmd = "StartupTime",
}

-- tpope plug
tools["tpope/vim-eunuch"] = {
	event = "BufReadPre",
}
tools["tpope/vim-repeat"] = {
	event = "BufReadPre",
}
-- https://gist.github.com/wilon/ac1fc66f4a79e7b0c161c80877c75c94
tools["tpope/vim-surround"] = {
	event = "BufReadPre",
}

-- quick choice
tools["gcmt/wildfire.vim"] = {
	event = "BufReadPre",
}

-- Debugger
-- https://github.com/puremourning/vimspector#supported-languages
tools["puremourning/vimspector"] = {
	event = "BufReadPre",
	run = "./install_gadget.py --enable-go --enable-rust --no-check-certificate",
	config = conf.vimspector,
	setup = conf.vimspector_setup,
	requires = {
		-- UI Component Library for Neovim.
		{ "MunifTanjim/nui.nvim", opt = true },
	},
}

-- Insert or delete brackets, parens, quotes in pair
tools["windwp/nvim-autopairs"] = {
	event = "BufReadPre",
	config = conf.autopairs,
}

-- class outline viewer
-- use 'majutsushi/tagbar'
-- use 'liuchengxu/vista.vim'

-- Smooth scrolling for Vim done right
tools["psliwka/vim-smoothie"] = {
	event = "BufReadPre",
	setup = conf.smoothie_setup,
}

tools["monkoose/matchparen.nvim"] = {
	event = "BufReadPre",
	config = conf.matchparen,
}

-- zbirenbaum/copilot.lua
-- zbirenbaum/copilot-cmp
-- tools["github/copilot.vim"] = {
--     cmd = "Copilot",
-- }

return tools
