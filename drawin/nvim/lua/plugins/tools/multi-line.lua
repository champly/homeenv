return {
	-- choice multi line
	{
		"mg979/vim-visual-multi",
		event = "BufReadPre",
		init = function()
			---@diagnostic disable-next-line: inject-field
			vim.g.VM_show_warnings = 0
			---@diagnostic disable-next-line: inject-field
			vim.g.VM_leader = "\\"
			---@diagnostic disable-next-line: inject-field
			vim.g.VM_maps = {
				Undo = "u",
				Redo = "<C-r>",
				["Add Cursor Down"] = "<M-j>", -- 往下增加光标 Opt+j
				["Add Cursor Up"] = "<M-k>", -- 往上增加光标 Opt+k
				-- ["Select All"] = '\\A',
			}
			---@diagnostic disable-next-line: inject-field
			vim.g.VM_no_meta_mappings = {
			}

			-- Opt+h Opt+l 在多光标模式下 可以移动单个光标 而不是所有光标
			vim.api.nvim_set_keymap("n", "<M-h>", "<Left>", {})
			vim.api.nvim_set_keymap("n", "<M-l>", "<Right>", {})
		end,
	}
}
