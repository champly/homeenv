return {
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		config = function()
			require("gitsigns").setup({
				signs                   = {
					-- add          = { text = '│' },
					change       = { text = '▒' },
					-- delete       = { text = '_' },
					-- topdelete    = { text = '‾' },
					changedelete = { text = '░' },
					-- untracked    = { text = '┆' },
				},
				current_line_blame      = true,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
					delay = 500,
					ignore_whitespace = true
				},
			})

			-- https://github.com/lewis6991/gitsigns.nvim/issues/430
			vim.cmd([[ highlight gitsignscurrentlineblame guibg=None guifg=#756969 ]])
		end,
	},
	{
		"sindrets/diffview.nvim",
		cmd = {
			"DiffviewOpen",
			"DiffviewFileHistory",
		},
		opts = {
			view = {
				merge_tool = {
					layout = "diff3_mixed",
				}
			}
		}
	}
}
