return {
	-- class outline viewer
	-- symbols outline
	{
		"hedyhli/outline.nvim",
		keys = {
			{ "<space>o", ":Outline<cr>", desc = "outline" },
		},
		config = function()
			require("outline").setup({
				outline_window = {
					auto_close = true,
					wrap = true,
				},
			})
			vim.cmd([[ hi OutlineCurrent gui=bold guifg=blue ]])
		end,
	}
}
