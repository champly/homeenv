return {
	-- Smooth scrolling for Vim done right
	{
		"psliwka/vim-smoothie",
		event = "BufReadPre",
		init = function()
			---@diagnostic disable-next-line: inject-field
			vim.g.smoothie_remapped_commands = {
				"<C-D>",
				"<C-U>",
				"<C-F>",
				"<S-Down>",
				"<PageDown>",
				"<C-B>",
				"<S-Up>",
				"<PageUp>",
				"z+",
				"z^",
				"z<CR>",
				"z.",
				"z-",
				-- "zt",
				-- "zz",
				-- "zb",
			}
		end,
	}
}
