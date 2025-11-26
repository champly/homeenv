-- Filetype overrides recommended by :help vim.filetype.add
vim.filetype.add({
	extension = {
		ncl = "nickel",
		nkl = "nickel",
		bxl = "bzl",
	},
	filename = {
		["BUCK"] = "bzl",
		["TARGETS"] = "bzl",
	},
})

-- Restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(event)
		local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(event.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			pcall(vim.api.nvim_win_set_cursor, 0, { mark[1], mark[2] })
			vim.cmd("normal! zz")
		end
	end,
})

-- -- https://github.com/folke/dot/blob/master/nvim/lua/config/autocmds.lua
-- -- show cursor line only in active window
-- vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
--     callback = function()
--         if vim.w.auto_cursorline then
--             vim.wo.cursorline = true
--             ---@diagnostic disable-next-line: inject-field
--             vim.w.auto_cursorline = nil
--         end
--     end,
-- })
-- vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
--     callback = function()
--         if vim.wo.cursorline then
--             ---@diagnostic disable-next-line: inject-field
--             vim.w.auto_cursorline = true
--             vim.wo.cursorline = false
--         end
--     end,
-- })

-- Auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd("VimResized", {
	command = "wincmd =",
})

-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
	pattern = "NvimTree_*",
	callback = function()
		local layout = vim.fn.winlayout()
		if layout[1] == "leaf" and vim.bo[vim.api.nvim_win_get_buf(layout[2])].filetype == "NvimTree" and layout[3] == nil then
			vim.cmd("confirm quit")
		end
	end
})

-- https://github.com/mhinz/vim-grepper/issues/117
-- FIXME: auto close when quickfix is last window
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function(event)
		if vim.fn.mapcheck("<Esc>", "n") == "" then
			vim.keymap.set("n", "<Esc>", function()
				pcall(vim.cmd, "cclose")
				pcall(vim.cmd, "lclose")
			end, { buffer = event.buf, silent = true, desc = "Close quickfix" })
		end
	end
})
