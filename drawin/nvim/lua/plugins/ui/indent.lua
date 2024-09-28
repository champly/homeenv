return {
	{
		"shellRaining/hlchunk.nvim",
		init = function()
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, { pattern = "*", command = "EnableHL", })
			require("hlchunk").setup({
				chunk = {
					enable = true,
					use_treesitter = true,
					style = {
						{ fg = "#806d9c" },
					},
				},
				indent = {
					chars = { "│", "¦", "┆", "┊", },
					use_treesitter = false,
				},
				blank = {
					enable = false,
				},
				line_num = {
					use_treesitter = true,
				},
			})
		end,
	}
	-- -- Active indent guide and indent text objects. When you're browsing
	-- -- code, this highlights the current level of indentation, and animates
	-- -- the highlighting.
	-- {
	--     "echasnovski/mini.indentscope",
	--     opts = {
	--         draw = {
	--             animation = function(s, n)
	--                 return 5
	--             end,
	--         },
	--         options = {
	--             try_as_border = true,
	--         },
	--     },
	--     init = function()
	--         vim.api.nvim_create_autocmd("FileType", {
	--             pattern = {
	--                 "help",
	--                 "alpha",
	--                 "dashboard",
	--                 "neo-tree",
	--                 "Trouble",
	--                 "trouble",
	--                 "lazy",
	--                 "mason",
	--                 "notify",
	--                 "toggleterm",
	--                 "lazyterm",
	--                 "outline",
	--             },
	--             callback = function()
	--                 ---@diagnostic disable-next-line: inject-field
	--                 vim.b.miniindentscope_disable = true
	--             end,
	--         })
	--     end,
	-- }
}
