return {
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		ft = "markdown",
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
					folder = "Daily/Tencent"
				}
			}
		end,

	},
	-- {
	--     "vimwiki/vimwiki",
	--     cmd = {
	--         "VimwikiMakeDiaryNote",
	--         "VimwikiIndex",
	--     },
	--     init = function()
	--         ---@diagnostic disable-next-line: inject-field
	--         vim.g.vimwiki_list = {
	--             {
	--                 path = "~/Dropbox/notebook/vimwiki/",
	--                 syntax = "markdown",
	--                 ext = ".md"
	--             }
	--         }

	--         vim.api.nvim_set_keymap("n", "<leader>wd", ":VimwikiMakeDiaryNote<cr>", { silent = true })
	--         vim.api.nvim_set_keymap("n", "<leader>ww", ":VimwikiIndex<cr>", { silent = true })
	--     end,
	-- }
}
