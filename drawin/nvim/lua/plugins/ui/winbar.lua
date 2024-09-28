return {
	{
		"Bekaboo/dropbar.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		config = function()
			require("dropbar").setup({})
			vim.keymap.set({ "n" }, "<C-p>", ":lua require('dropbar.api').pick()<cr>")
			vim.cmd [[ hi DropBarIconKindFolder guifg=#DAA520 ]]
		end
	}
}
