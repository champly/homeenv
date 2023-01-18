local M = {}

M.hide_statusline = function()
	local shown = {}
	local hidden = {
		"help",
		"dashboard",
		"NvimTree",
		"terminal",
	}

	local buftype = vim.api.nvim_buf_get_option(0, "ft")

	-- show table from config has the highest priority
	if vim.tbl_contains(shown, buftype) then
		vim.api.nvim_set_option("laststatus", 2)
		return
	end

	if vim.tbl_contains(hidden, buftype) then
		vim.api.nvim_set_option("laststatus", 0)
		return
	end

	vim.api.nvim_set_option("laststatus", 2)
end

return M
