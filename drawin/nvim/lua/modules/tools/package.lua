local package = require("core.pack").package
local conf = require("modules.tools.config")

-- debug
package({
	"tweekmonster/startuptime.vim",
	cmd = "StartupTime",
})

-- tpope plug
package({
	"tpope/vim-eunuch",
	event = "BufReadPre",
})

package({
	"tpope/vim-repeat",
	event = "BufReadPre",
})

-- https://gist.github.com/wilon/ac1fc66f4a79e7b0c161c80877c75c94
package({
	"tpope/vim-surround",
	event = "BufReadPre",
})

-- quick choice
package({
	"gcmt/wildfire.vim",
	event = "BufReadPre",
})

-- Debugger
-- https://github.com/puremourning/vimspector#supported-languages
package({
	"puremourning/vimspector",
	event = "BufReadPre",
	build = "./install_gadget.py --enable-go --enable-rust --no-check-certificate",
	config = conf.vimspector,
	init = conf.vimspector_setup,
	dependencies = {
		-- UI Component Library for Neovim.
		{ "MunifTanjim/nui.nvim", lazy = true },
	},
})

-- Insert or delete brackets, parens, quotes in pair
package({
	"windwp/nvim-autopairs",
	event = "BufReadPre",
	config = conf.autopairs,
})

-- class outline viewer
-- use 'majutsushi/tagbar'
-- use 'liuchengxu/vista.vim'

-- Smooth scrolling for Vim done right
package({
	"psliwka/vim-smoothie",
	event = "BufReadPre",
	init = conf.smoothie_setup,
})

package({
	"monkoose/matchparen.nvim",
	event = "BufReadPre",
	config = conf.matchparen,
})

-- zbirenbaum/copilot.lua
-- zbirenbaum/copilot-cmp
-- tools["github/copilot.vim"] = {
--     cmd = "Copilot",
-- }
