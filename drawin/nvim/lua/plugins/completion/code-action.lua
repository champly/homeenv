return {
	{
		"rachartier/tiny-code-action.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim" },
		},
		-- keys = {
		--     { "<leader>ca", function() require("tiny-code-action").code_action() end, mode = { "n" }, desc = "Code Action" },
		-- },
		event = "LspAttach",
		config = function()
			require("tiny-code-action").setup()
			vim.keymap.set("n", "<leader>ca", function()
				require("tiny-code-action").code_action()
			end, { noremap = true, silent = true })
		end
	}
}
