return {
	-- search and replace
	{
		"windwp/nvim-spectre",
		keys = {
			{ "<leader>S",  mode = { "n" }, function() require("spectre").toggle() end,                                 desc = "Toggle Spectre" },
			{ "<leader>sw", mode = { "n" }, function() require("spectre").open_visual({ select_word = true }) end,      desc = "Search current word" },
			{ "<leader>sw", mode = { "v" }, function() require("spectre").open_visual() end,                            desc = "Search current word" },
			{ "<leader>sp", mode = { "n" }, function() require("spectre").open_file_search({ select_word = true }) end, desc = "Search on current file" }
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		opts = function()
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
			return opt
		end
	}
}
