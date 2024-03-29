local completion = {}
local conf = require("modules.completion.config")

completion["neovim/nvim-lspconfig"] = {
	-- event = "BufRead",
	disable = not completion_with_lsp,
	after = "telescope.nvim",
	ft = { "go", "lua", "rust", "c", "cpp" },
	config = conf.nvim_lsp,
}

-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion#nvim-cmp
completion["hrsh7th/nvim-cmp"] = {
	event = "InsertEnter",
	disable = not completion_with_lsp,
	config = conf.nvim_cmp,
	requires = {
		{ "hrsh7th/cmp-nvim-lsp", after = "nvim-lspconfig" },
		{ "hrsh7th/cmp-path", after = "nvim-cmp" },
		{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
		{ "L3MON4D3/LuaSnip", after = "nvim-cmp" },
		{ "saadparwaiz1/cmp_luasnip", after = "LuaSnip" },
		{ "hrsh7th/cmp-nvim-lua", after = "cmp_luasnip" },
	}
}

-- winbar use LSP to show your current code context.
completion["SmiteshP/nvim-navic"] = {
	requires = "neovim/nvim-lspconfig",
	config = function()
		require("nvim-navic").setup {
			highlight = true,
		}
	end
}

-- completion["glepnir/lspsaga.nvim"] = {
--     cmd = "Lspsaga",
--     disable = not completion_with_lsp,
--     config = conf.lspsaga_nvim,
-- }

completion["ray-x/lsp_signature.nvim"] = {
	after = "nvim-lspconfig",
	disable = not completion_with_lsp,
}

-- code-completion engine
completion["neoclide/coc.nvim"] = {
	event = "BufRead",
	branch = "release",
	disable = completion_with_lsp,
	config = function()
		local cmd = "source " .. vim.fn.stdpath("config") .. "/lua/modules/completion/coc.vim"
		vim.api.nvim_exec(cmd, false)
	end
}

-- go language support
-- use 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

completion["nvim-telescope/telescope.nvim"] = {
	cmd = "Telescope",
	event = "BufRead",
	config = conf.telescope,
	requires = {
		{ "nvim-lua/popup.nvim", opt = true },
		{ "nvim-lua/plenary.nvim", opt = true },
		{ "nvim-telescope/telescope-fzy-native.nvim", opt = true },
		{ "nvim-telescope/telescope-ui-select.nvim", opt = true },
	}
}

return completion
