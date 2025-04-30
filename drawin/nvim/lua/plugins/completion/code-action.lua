return {
	{
		"aznhe21/actions-preview.nvim",
		keys = {
			{ "<leader>ca", function() require("actions-preview").code_actions() end, mode = { "n" }, desc = "Code Action" },
		},
		opts = {
			backend = { "snacks" },
			snacks = {
				layout = { preset = "dropdown" },
			},
		}
	},
	-- {
	-- 	"rachartier/tiny-code-action.nvim",
	-- 	dependencies = {
	-- 		{ "nvim-lua/plenary.nvim" },
	-- 	},
	-- 	keys = {
	-- 		{ "<leader>ca", function() require("tiny-code-action").code_action() end, mode = { "n" }, desc = "Code Action" },
	-- 	},
	-- 	opts = {
	-- 		picker = {
	-- 			"snacks",
	-- 		}
	-- 	},
	-- }
}
