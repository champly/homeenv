return {
	{

		"rcarriga/nvim-notify",
		config = function()
			---@diagnostic disable-next-line: param-type-mismatch
			vim.notify = vim.schedule_wrap(require("notify"))

			---@diagnostic disable-next-line: duplicate-set-field
			function _G.save_file_with_notify()
				---@diagnostic disable-next-line: param-type-mismatch
				local ok, msg = pcall(vim.cmd, "silent write!")
				if ok then
					vim.notify("Saved " .. vim.fn.expand "%:t", nil, {
						title = "Success",
						timeout = 1000
					})
				else
					---@diagnostic disable-next-line: param-type-mismatch
					vim.notify(msg, "error", {
						title = "Error",
						timeout = 1000
					})
				end
			end

			vim.api.nvim_set_keymap("n", "<leader>s", "<cmd>lua save_file_with_notify()<cr>",
				{ noremap = true, silent = true })
		end,
	}
}
