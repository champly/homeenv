return {
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		keys = {
			{ "<leader>ds", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)", },
		},
		opts = {}, -- for default options, refer to the configuration section for custom setup.
	}
}
