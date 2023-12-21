local package = require("core.pack").package
local conf = require("modules.tools.config")

package({
	"nvim-treesitter/nvim-treesitter",
	event = "BufRead",
	dependencies = "telescope.nvim",
	build = ":TSUpdate",
	config = conf.nvim_treesitter,
})

-- package({
--     "nvim-treesitter/nvim-treesitter-textobjects",
--     dependencies = "nvim-treesitter"
-- })

package({
	"iamcco/markdown-preview.nvim",
	build = "cd app && yarn install",
	ft = { "markdown" },
	init = conf.markdown_preview_nvim_setup,
	dependencies = {
		{ "plasticboy/vim-markdown" },
		{ "dhruvasagar/vim-table-mode" },
	}
})

-- annotate plugin: https://github.com/preservim/nerdcommenter#settings
package({
	"preservim/nerdcommenter",
	event = "BufRead",
	init = function()
		-- 注释的时候自动加个空格,强迫症必配
		vim.g.NERDSpaceDelims = 1
	end
})

-- The plug-in visualizes undo history and makes it easier to browse and switch between different undo branches
package({
	"mbbill/undotree",
	event = "BufRead",
	config = conf.undotree,
})

-- VimWiki is a personal wiki for Vim
package({
	"vimwiki/vimwiki",
	cmd = {
		"VimwikiMakeDiaryNote",
		"VimwikiIndex",
	},
	init = conf.vimwiki_setup,
})

-- choice multi line
package({
	"mg979/vim-visual-multi",
	event = "BufReadPre",
	branch = "master",
	config = conf.vim_visual_multi_setup,
})

-- Jump to any location specified by two characters.
package({
	"phaazon/hop.nvim",
	event = "BufReadPre",
	config = conf.hop_nvim,
	init = conf.hop_nvim_setup,
})

-- symbols outline
package({
	-- "simrat39/symbols-outline.nvim",
	"hedyhli/outline.nvim",
	event = "BufRead",
	enabled = vim.g.completion_with_lsp,
	config = conf.outline_nvim,
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
package({
	"mfussenegger/nvim-dap",
	event = "BufReadPre",
	config = conf.nvim_dap,
})

package({
	"rcarriga/nvim-dap-ui",
	event = "BufReadPre",
	dependencies = {
		"mfussenegger/nvim-dap",
	},
	config = conf.nvim_dap_ui,
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

package({
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = {
		dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
		options = { "buffers", "curdir", "tabpages", "winsize" },
		pre_save = nil,
	}
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

-- package({
--     "sbdchd/neoformat",
--     event = "BufReadPre",
--     config = conf.neoformat,
-- })

-- zbirenbaum/copilot.lua
-- zbirenbaum/copilot-cmp
-- package({
--    "github/copilot.vim",
--     cmd = "Copilot",
-- }
