return {
	-- MagicDuck/grug-far.nvim
	-- search and replace
	{
		"windwp/nvim-spectre",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<leader>S",  function() require("spectre").toggle() end,                                 mode = { "n" }, desc = "Toggle Spectre" },
			{ "<leader>sw", function() require("spectre").open_visual({ select_word = true }) end,      mode = { "n" }, desc = "Search current word" },
			{ "<leader>sw", function() require("spectre").open_visual() end,                            mode = { "v" }, desc = "Search current word" },
			{ "<leader>sp", function() require("spectre").open_file_search({ select_word = true }) end, mode = { "n" }, desc = "Search on current file" }
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
