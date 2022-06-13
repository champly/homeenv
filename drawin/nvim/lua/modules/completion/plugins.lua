local completion = {}
local conf = require("modules.completion.config")

completion["neovim/nvim-lspconfig"] = {
	event = "BufReadPre",
	disable = not completion_with_lsp,
	config = conf.nvim_lsp,
}

-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion#nvim-cmp
completion["hrsh7th/nvim-cmp"] = {
	event = "InsertEnter",
	disable = not completion_with_lsp,
	config = conf.nvim_cmp,
}

completion["L3MON4D3/LuaSnip"] = {
	after = "nvim-cmp",
	disable = not completion_with_lsp,
}

completion["saadparwaiz1/cmp_luasnip"] = {
	after = "LuaSnip",
	disable = not completion_with_lsp,
}

completion["hrsh7th/cmp-nvim-lua"] = {
	after = "cmp_luasnip",
	disable = not completion_with_lsp,
}

completion["hrsh7th/cmp-nvim-lsp"] = {
	after = "cmp-nvim-lua",
	disable = not completion_with_lsp,
}

completion["hrsh7th/cmp-buffer"] = {
	after = "cmp-nvim-lsp",
	disable = not completion_with_lsp,
}

completion["hrsh7th/cmp-path"] = {
	after = "cmp-buffer",
	disable = not completion_with_lsp,
}

-- -- TODO: use this replace glepnir/lspsaga.nvim
-- completion["tami5/lspsaga.nvim"] = {
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
	config = conf.telescope,
	requires = {
		{ "nvim-lua/popup.nvim", opt = true },
		{ "nvim-lua/plenary.nvim", opt = true },
		{ "nvim-telescope/telescope-fzy-native.nvim", opt = true },
		{ "nvim-telescope/telescope-ui-select.nvim", opt = true },
	}
}

return completion
