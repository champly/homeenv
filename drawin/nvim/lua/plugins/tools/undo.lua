return {
	-- The plug-in visualizes undo history and makes it easier to browse and switch between different undo branches
	{
		"debugloop/telescope-undo.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>u", "<cmd>Telescope undo<cr>", desc = "undo history" },
		},
	}
}
