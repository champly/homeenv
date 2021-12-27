vim.notify = require("notify")

function _G._save_file()
	local ok, msg = pcall(vim.cmd, "silent write!")
	if ok then
		vim.notify("Saved " .. vim.fn.expand "%:t", nil, { title = "Success", timeout = 1000 })
	else
		vim.notify(msg, "error", { title = "Error", timeout = 1000 })
	end
end

vim.api.nvim_set_keymap(
	"n",
	"<leader>s",
	"<cmd>lua _save_file()<cr>",
	{ silent = true, noremap = true }
)

