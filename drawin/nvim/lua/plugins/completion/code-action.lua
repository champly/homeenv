return {
	{
		"aznhe21/actions-preview.nvim",
		keys = {
			{ "<leader>ca", function() require("actions-preview").code_actions() end, mode = { "n" }, desc = "Code Action" },
		},
		opts = {
			-- TODO: use snacks.picker, remove telescope
			-- snacks = {
			-- 	layout = { preset = "default" },
			-- },
		}
	}
}
