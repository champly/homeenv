return {
	-- search and replace
	{
		"windwp/nvim-spectre",
		keys = {
			"<leader>S",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local opt = {}
			---@diagnostic disable-next-line: undefined-field
			if vim.uv.os_uname().sysname == "Darwin" then
				-- https://github.com/nvim-pack/nvim-spectre/issues/118#issuecomment-1531683211
				opt = {
					replace_engine = {
						["sed"] = {
							cmd = "sed",
							args = {
								"-i",
								"",
								"-E",
							},
						},
					},
				}
			end
			require("spectre").setup(opt)

			vim.keymap.set("n", "<leader>S", "<cmd>lua require('spectre').toggle()<CR>", { desc = "Toggle Spectre" })
			vim.keymap.set("n", "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", {
				desc = "Search current word"
			})
			vim.keymap.set("v", "<leader>sw", "<esc><cmd>lua require('spectre').open_visual()<CR>",
				{ desc = "Search current word" })
			vim.keymap.set("n", "<leader>sp", "<cmd>lua require('spectre').open_file_search({select_word=true})<CR>",
				{ desc = "Search on current file" })
		end,
	}
}
