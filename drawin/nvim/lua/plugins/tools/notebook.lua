return {
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*",
		lazy = true,
		ft = "markdown",
		cmd = "ObsidianToday",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		---@diagnostic disable-next-line: undefined-field
		enabled = vim.uv.os_uname().sysname == "Darwin",
		opts = function()
			local path = os.getenv("HOME") .. "/Library/Mobile Documents/com~apple~CloudDocs/notebook"
			---@diagnostic disable-next-line: undefined-field
			if not vim.uv.fs_stat(path) then
				path = os.getenv("HOME") .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/notebook"
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
			}
		end,
	},
}
