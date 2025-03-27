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
			vim.api.nvim_set_hl(0, "OutlineCurrent", { fg = "blue", bold = true })
		end,
	}
}
