local tools = {}
local conf = require("modules.tools.config")

-- fzf
-- use { 'junegunn/fzf', run = { -> fzf#install() }
-- use 'junegunn/fzf.vim'

-- debug
tools["tweekmonster/startuptime.vim"] = {}

-- tpope plug
tools["tpope/vim-eunuch"] = {}
tools["tpope/vim-repeat"] = {}
-- https://gist.github.com/wilon/ac1fc66f4a79e7b0c161c80877c75c94
tools["tpope/vim-surround"] = {}
tools["gcmt/wildfire.vim"] = {}

-- Debugger
-- https://github.com/puremourning/vimspector#supported-languages
tools["puremourning/vimspector"] = {
	run = "./install_gadget.py --enable-go --enable-rust --no-check-certificate",
	config = conf.vimspector,
	requires = {
		-- UI Component Library for Neovim.
		{ "MunifTanjim/nui.nvim", opt = true },
	},
}

-- -- Insert or delete brackets, parens, quotes in pair
-- tools["jiangmiao/auto-pairs"] = {
--     event = "BufReadPre",
-- }
tools["windwp/nvim-autopairs"] = {
	event = "BufReadPre",
	config = conf.autopairs,
}

-- class outline viewer
-- use 'majutsushi/tagbar'
-- use 'liuchengxu/vista.vim'

-- Smooth scrolling for Vim done right
tools["psliwka/vim-smoothie"] = {
	config = conf.smoothie,
}

return tools
