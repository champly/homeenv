return {
	{
		"Bekaboo/dropbar.nvim",
		event = "BufReadPre",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		opts = {},
		keys = {
			{ "<C-p>", function() require("dropbar.api").pick() end, desc = "Dropbar pick", silent = true },
		},
		init = function()
			vim.api.nvim_set_hl(0, "DropBarIconKindFolder", { fg = "#daa520" })
		end
	}
}
