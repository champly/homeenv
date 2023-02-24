local package = require("core.pack").package
local conf = require("modules.completion.config")

package({
	"neovim/nvim-lspconfig",
	-- event = "BufRead",
	enabled = vim.g.completion_with_lsp,
	dependencies = "telescope.nvim",
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
	dependencies = "neovim/nvim-lspconfig",
	config = function()
		require("nvim-navic").setup {
			highlight = true,
		}
	end
})

-- package({
--	  "glepnir/lspsaga.nvim",
--     cmd = "Lspsaga",
--     enabled = vim.g.completion_with_lsp,
--     config = conf.lspsaga_nvim,
-- }

package({
	"ray-x/lsp_signature.nvim",
	dependencies = "nvim-lspconfig",
	enabled = vim.g.completion_with_lsp,
})

-- go language support
-- use 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

package({
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	event = "BufRead",
	config = conf.telescope,
	dependencies = {
		{ "nvim-lua/plenary.nvim",                    lazy = true },
		{ "nvim-telescope/telescope-fzy-native.nvim", lazy = true },
		{ "nvim-telescope/telescope-ui-select.nvim",  lazy = true },
		{ "nvim-lua/popup.nvim",                      lazy = true },
	}
})

-- code-completion engine
package({
	"neoclide/coc.nvim",
	event = "BufRead",
	branch = "release",
	enabled = not vim.g.completion_with_lsp,
	config = conf.nvim_coc,
})
