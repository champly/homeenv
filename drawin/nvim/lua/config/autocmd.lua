-- Restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.cmd('normal! g`"zz')
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
		local layout = vim.api.nvim_call_function("winlayout", {})
		if layout[1] == "leaf" and vim.bo[vim.api.nvim_win_get_buf(layout[2])].filetype == "NvimTree" and layout[3] == nil then
			vim.cmd("confirm quit")
		end
	end
})

-- auto spell
-- { "BufRead,BufNewFile", "*.md",        "setlocal spell" },
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.md" },
	callback = function()
		vim.cmd([[setlocal spell]])
	end
})

-- set nickel filetype
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.ncl", "*.nkl" },
	callback = function()
		vim.cmd([[set filetype=nickel]])
	end
})
-- set BUCK filetype
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.bxl", "BUCK", "TARGETS" },
	callback = function()
		vim.cmd([[set filetype=bzl]])
	end
})

-- https://github.com/mhinz/vim-grepper/issues/117
-- FIXME: auto close when quickfix is last window
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.cmd([[if mapcheck('<esc>', 'n') ==# '' | nnoremap <buffer><silent> <esc> :cclose<bar>lclose<cr> | endif]])
	end
})
