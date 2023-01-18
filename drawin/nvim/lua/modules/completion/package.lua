local package = require("core.pack").package
local conf = require("modules.completion.config")

package({
	"neovim/nvim-lspconfig",
	-- event = "BufRead",
	enabled = vim.g.completion_with_lsp,
	dependencies = "telescope.nvim",
	ft = { "go", "lua", "rust", "c", "cpp" },
	config = conf.nvim_lsp,
})

-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion#nvim-cmp
package({
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	enabled = vim.g.completion_with_lsp,
	config = conf.nvim_cmp,
	dependencies = {
		{ "hrsh7th/cmp-nvim-lsp", dependencies = "nvim-lspconfig" },
		{ "hrsh7th/cmp-path", dependencies = "nvim-cmp" },
		{ "hrsh7th/cmp-buffer", dependencies = "nvim-cmp" },
		{ "L3MON4D3/LuaSnip", dependencies = "nvim-cmp" },
		{ "saadparwaiz1/cmp_luasnip", dependencies = "LuaSnip" },
		{ "hrsh7th/cmp-nvim-lua", dependencies = "cmp_luasnip" },
	}
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

-- code-completion engine
package({
	"neoclide/coc.nvim",
	event = "BufRead",
	branch = "release",
	enabled = not vim.g.completion_with_lsp,
	config = function()
		local cmd = "source " .. vim.fn.stdpath("config") .. "/lua/modules/completion/coc.vim"
		vim.api.nvim_exec(cmd, false)
	end
})

-- go language support
-- use 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

package({
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	event = "BufRead",
	config = conf.telescope,
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
		{ "nvim-lua/popup.nvim", lazy = true },
		{ "nvim-telescope/telescope-fzy-native.nvim", lazy = true },
		{ "nvim-telescope/telescope-ui-select.nvim", lazy = true },
	}
})
