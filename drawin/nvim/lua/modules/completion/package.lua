local package = require("core.pack").package
local conf = require("modules.completion.config")

package({
	"neovim/nvim-lspconfig",
	-- event = "BufRead",
	enabled = vim.g.completion_with_lsp,
	dependencies = {
		"telescope.nvim",
	},
	ft = { "go", "lua", "rust", "c", "cpp", "markdown" },
	config = conf.nvim_lsp,
})

-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion#nvim-cmp
package({
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	enabled = vim.g.completion_with_lsp,
	config = conf.nvim_cmp,
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		-- "L3MON4D3/LuaSnip",
		-- "saadparwaiz1/cmp_luasnip",
		-- "hrsh7th/cmp-nvim-lua",
	}
})

package({
	"L3MON4D3/LuaSnip",
	event = "InsertCharPre",
	-- version = "<CurrentMajor>.*",
	build = "make install_jsregexp",
	enabled = vim.g.completion_with_lsp,
	dependencies = "saadparwaiz1/cmp_luasnip",
	config = conf.lua_snip
})

-- winbar use LSP to show your current code context.
package({
	"SmiteshP/nvim-navic",
	event = "BufRead",
	dependencies = "neovim/nvim-lspconfig",
	config = function()
		require("nvim-navic").setup {
			highlight = true,
		}
	end
})

package({
	"nvimdev/lspsaga.nvim",
	event = "LspAttach",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		-- Please make sure you install markdown and markdown_inline parser
		{ "nvim-treesitter/nvim-treesitter" }
	},
	enabled = vim.g.completion_with_lsp and false,
	config = conf.lspsaga_nvim
})

package({
	"ray-x/lsp_signature.nvim",
	event = "InsertCharPre",
	dependencies = "nvim-lspconfig",
	enabled = vim.g.completion_with_lsp,
})

-- go language support
-- use 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

-- code-completion engine
package({
	"neoclide/coc.nvim",
	event = "BufRead",
	branch = "release",
	enabled = not vim.g.completion_with_lsp,
	config = conf.nvim_coc,
})
