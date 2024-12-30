-- 文件打开的时候光标停留在上次关闭时候的位置
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local line = vim.fn.line('\'"')
		if line > 1 and line <= vim.fn.line('$') then
			vim.cmd.normal('g\'"')
		end
	end
})

-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
	pattern = "NvimTree_*",
	callback = function()
		local layout = vim.api.nvim_call_function("winlayout", {})
		---@diagnostic disable-next-line: deprecated
		if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" and layout[3] == nil then
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
