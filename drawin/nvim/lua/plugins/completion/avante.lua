return {
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false, -- Never set this value to "*"! Never!
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		keys = {
			{ "<leader>aa", "<cmd>Avante<cr>",      desc = "Ask Avante AI" },
			{ "<leader>ac", "<cmd>AvanteClear<cr>", desc = "Clear the chat history" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			-- add any opts here
			-- for example
			provider = "ollama",
			ollama = {
				model = "deepseek-r1:14b",
			},
		},
	},
}
