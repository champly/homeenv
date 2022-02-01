local completion = {}
local conf = require("modules.completion.config")

completion["neovim/nvim-lspconfig"] = {
	disable = not completion_with_lsp,
	event = "BufReadPre",
	config = conf.nvim_lsp,
}

-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion#nvim-cmp
completion["hrsh7th/nvim-cmp"] = {
	disable = not completion_with_lsp,
	event = "InsertEnter",
	config = conf.nvim_cmp,
}

completion["L3MON4D3/LuaSnip"] = {
	disable = not completion_with_lsp,
	after = "nvim-cmp",
}

completion["saadparwaiz1/cmp_luasnip"] = {
	disable = not completion_with_lsp,
	after = "LuaSnip",
}

completion["hrsh7th/cmp-nvim-lua"] = {
	disable = not completion_with_lsp,
	after = "cmp_luasnip",
}

completion["hrsh7th/cmp-nvim-lsp"] = {
	disable = not completion_with_lsp,
	after = "cmp-nvim-lua",
}

completion["hrsh7th/cmp-buffer"] = {
	disable = not completion_with_lsp,
	after = "cmp-nvim-lsp",
}

completion["hrsh7th/cmp-path"] = {
	disable = not completion_with_lsp,
	after = "cmp-buffer",
}

-- -- TODO: use this replace glepnir/lspsaga.nvim
-- completion["tami5/lspsaga.nvim"] = {
--     disable = not completion_with_lsp,
--     config = conf.lspsaga_nvim,
-- }

completion["ray-x/lsp_signature.nvim"] = {
	disable = not completion_with_lsp,
	after = "nvim-lspconfig",
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
	config = conf.telescope,
	requires = {
		{ "nvim-lua/popup.nvim", opt = true },
		{ "nvim-lua/plenary.nvim", opt = true },
		{ "nvim-telescope/telescope-fzy-native.nvim", opt = true },
	}
}

return completion
