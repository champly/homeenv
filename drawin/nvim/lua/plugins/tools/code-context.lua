return {
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPre",
		opts = {},
		init = function()
			vim.api.nvim_set_hl(0, "TreesitterContextBottom", { bg = "#e9e9e9", bold = true })
		end
	}
}
