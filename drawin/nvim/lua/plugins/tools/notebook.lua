return {
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*",
		lazy = true,
		cmd = "Obsidian",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		---@diagnostic disable-next-line: undefined-field
		enabled = vim.uv.os_uname().sysname == "Darwin",
		opts = function()
			local paths = {
				os.getenv("HOME") .. "/Documents/notebook",
				os.getenv("HOME") .. "/Library/Mobile Documents/com~apple~CloudDocs/notebook",
			}
			local path = "/tmp"
			for _, p in ipairs(paths) do
				---@diagnostic disable-next-line: undefined-field
				if vim.uv.fs_stat(p) then
					path = p
					break
				end
			end

			return {
				workspaces = {
					{
						name = "icloud",
						path = path,
					},
				},
				daily_notes = {
					folder = "Daily/Tencent",
					date_format = "%Y年%m月%d日"
				},
				-- https://github.com/obsidian-nvim/obsidian.nvim/wiki/Commands
				legacy_commands = false,
			}
		end,
	},
}
