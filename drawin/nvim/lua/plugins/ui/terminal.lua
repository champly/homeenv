return {
	{
		"akinsho/toggleterm.nvim",
		keys = {
			{ "<F3>", "<cmd>ToggleTerm<CR>", mode = { "n" }, desc = "Toggle Term" },
		},
		opts = {
			size = function(term)
				if term.direction == "horizontal" then
					return 12
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				else
					return 20
				end
			end,
			open_mapping = "<F3>",
			-- "vertical" | "horizontal" | "tab" | "float"
			direction = "float"
			-- 在终端中，按下<C-\><C-n>（也就是按下Ctrl+\然后按下Ctrl+n）来进入正常模式
		}
	}
}
