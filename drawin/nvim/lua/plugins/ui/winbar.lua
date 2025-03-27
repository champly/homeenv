return {
	{
		"Bekaboo/dropbar.nvim",
		event = "BufReadPre",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		config = function()
			require("dropbar").setup({})
			vim.keymap.set({ "n" }, "<C-p>", ":lua require('dropbar.api').pick()<cr>", { silent = true })
			vim.api.nvim_set_hl(0, "DropBarIconKindFolder", { fg = "#daa520" })
		end
	}
}
