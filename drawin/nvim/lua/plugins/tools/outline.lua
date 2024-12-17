return {
	-- class outline viewer
	-- symbols outline
	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = {
			{ "<space>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
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
