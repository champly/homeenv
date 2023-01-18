local package = require("core.pack").package
local conf = require("modules.lang.config")

package({
	"nvim-treesitter/nvim-treesitter",
	event = "BufRead",
	dependencies = "telescope.nvim",
	config = conf.nvim_treesitter,
	build = ":TSUpdate",
})

package({
	"nvim-treesitter/nvim-treesitter-textobjects",
	dependencies = "nvim-treesitter"
})

package({
	"iamcco/markdown-preview.nvim",
	build = "cd app && yarn install",
	ft = { "markdown" },
	init = conf.markdown_preview_nvim_setup,
	dependencies = {
		{ "plasticboy/vim-markdown", lazy = true },
		{ "dhruvasagar/vim-table-mode", lazy = true },
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
	event = "BufRead",
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
	"simrat39/symbols-outline.nvim",
	event = "BufRead",
	enabled = vim.g.completion_with_lsp,
	config = conf.symbols_outline,
})

-- package({
--     "folke/trouble.nvim",
--     event = "BufRead",
--     enabled = vim.g.completion_with_lsp,
--     config = conf.trouble,
--     dependencies = "kyazdani42/nvim-web-devicons",
-- })
