return {
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && yarn install",
		ft = { "markdown" },
		dependencies = {
			{ "plasticboy/vim-markdown" },
			{ "dhruvasagar/vim-table-mode" },
		},
		init = function()
			-- dhruvasagar/vim-table-mode
			vim.api.nvim_set_keymap("n", "<leader>kv", ":MarkdownPrevie<CR>", { noremap = true })

			vim.api.nvim_set_keymap("n", "<leader>tm", ":TableModeToggle<cr>", {})
			---@diagnostic disable-next-line: inject-field
			vim.g.table_mode_cell_text_object_i_map = "k<Bar>"
		end,
	},
	{
		"OXY2DEV/markview.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons"
		},
		ft = { "markdown" },
	}
}
