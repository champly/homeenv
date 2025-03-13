return {
	"folke/snacks.nvim",
	opts = {
		picker = {}
	},
	keys = {
		-- find
		{ "<leader>fb", function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
		{ "<leader>fd", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
		{ "<leader>ff", function() Snacks.picker.files() end,                                   desc = "Find Files" },
		{ "<leader>fp", function() Snacks.picker.projects() end,                                desc = "Projects" },
		{ "<leader>fr", function() Snacks.picker.recent() end,                                  desc = "Recent" },
		-- grep
		{ "<leader>fl", function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
		{ "<leader>fw", function() Snacks.picker.grep() end,                                    desc = "Grep" },
		{ "<leader>fc", function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word", mode = { "n", "x" } },
		-- git
		{ "<leader>gl", function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
		-- mark
		{ "<leader>ml", function() Snacks.picker.marks() end,                                   desc = "Marks" },
		-- undo
		{ "<leader>u",  function() Snacks.picker.undo() end,                                    desc = "Undo History" },
	},
}
