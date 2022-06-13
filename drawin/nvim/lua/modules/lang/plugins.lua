local lang = {}
local conf = require("modules.lang.config")

lang["nvim-treesitter/nvim-treesitter"] = {
	event = "BufRead",
	after = "telescope.nvim",
	config = conf.nvim_treesitter,
	run = ":TSUpdate",
}

lang["nvim-treesitter/nvim-treesitter-textobjects"] = {
	after = "nvim-treesitter"
}

lang["iamcco/markdown-preview.nvim"] = {
	run = "cd app && yarn install",
	ft = { "markdown" },
	config = conf.markdown_preview_nvim,
	requires = {
		{ "plasticboy/vim-markdown", opt = true },
		{ "dhruvasagar/vim-table-mode", opt = true },
	}
}

-- annotate plugin: https://github.com/preservim/nerdcommenter#settings
lang["preservim/nerdcommenter"] = {
	event = "BufRead",
	config = function()
		-- 注释的时候自动加个空格,强迫症必配
		vim.g.NERDSpaceDelims = 1
	end
}

-- The plug-in visualizes undo history and makes it easier to browse and switch between different undo branches
lang["mbbill/undotree"] = {
	event = "BufRead",
	config = conf.undotree,
}

-- VimWiki is a personal wiki for Vim
lang["vimwiki/vimwiki"] = {
	config = conf.vimwiki,
}

-- quick find word
lang["brooth/far.vim"] = {
	event = "BufRead",
	config = conf.far_vim,
}

-- choice multi line
lang["mg979/vim-visual-multi"] = {
	event = "BufRead",
	branch = 'master',
	config = conf.vim_visual_multi,
}

lang["terryma/vim-multiple-cursors"] = {
	event = "BufReadPre"
}

-- Jump to any location specified by two characters.
lang["phaazon/hop.nvim"] = {
	event = "BufRead",
	config = conf.hop_nvim,
}

-- symbols outline
lang["simrat39/symbols-outline.nvim"] = {
	event = "BufRead",
	disable = not completion_with_lsp,
	config = conf.symbols_outline,
}

lang["folke/trouble.nvim"] = {
	event = "BufRead",
	disable = not completion_with_lsp,
	config = conf.trouble,
	requires = "kyazdani42/nvim-web-devicons",
}

return lang
