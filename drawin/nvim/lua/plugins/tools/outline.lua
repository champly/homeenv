return {
	-- class outline viewer
	-- symbols outline
	{
		"hedyhli/outline.nvim",
		event = "BufRead",
		config = function()
			require("outline").setup({
				outline_window = {
					auto_close = true,
					wrap = true,
				},
			})
			vim.api.nvim_set_keymap("n", "<space>o", ":Outline<cr>", { noremap = true, silent = true })
			vim.cmd [[ hi OutlineCurrent gui=bold guifg=blue ]]
		end,
	}
}
