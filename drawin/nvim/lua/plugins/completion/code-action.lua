return {
	{
		"rachartier/tiny-code-action.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim" },
		},
		keys = {
			{ "<leader>ca", function() require("tiny-code-action").code_action() end, "Code Action" },
		},
	}
}
