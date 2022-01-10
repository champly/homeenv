local completion = {}
local conf = require("modules.completion.config")

-- completion["neovim/nvim-lspconfig"] = {
--     event = "BufReadPre",
--     config = conf.nvim_lsp,
-- }

-- completion["hrsh7th/nvim-cmp"] = {
--     event = "InsertEnter",
--     config = conf.nvim_cmp,
--     requires = {
--         { "hrsh7th/cmp-nvim-lsp" },
--         { "hrsh7th/cmp-buffer" },
--         { "hrsh7th/cmp-path" },
--         { "hrsh7th/cmp-cmdline" },
--     },
-- }

completion["nvim-telescope/telescope.nvim"] = {
	config = conf.telescope,
	requires = {
		{ "nvim-lua/popup.nvim", opt = true },
		{ "nvim-lua/plenary.nvim", opt = true },
		{ "nvim-telescope/telescope-fzy-native.nvim", opt = true },
	}
}

-- code-completion engine
-- use 'Valloric/YouCompleteMe'
completion["neoclide/coc.nvim"] = {
	event = "BufRead",
	branch = "release",
	config = function()
		local cmd = "source " .. vim.fn.stdpath("config") .. "/lua/modules/completion/coc.vim"
		vim.api.nvim_exec(cmd, false)
	end
}

-- go language support
-- use 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

return completion
