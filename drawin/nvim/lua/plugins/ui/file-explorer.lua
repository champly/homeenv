return {
	{
		"nvim-tree/nvim-tree.lua",
		keys = {
			"ff",
		},
		config = function()
			-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Migrating-To-on_attach
			local function on_attach(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				-- default mappings
				api.config.mappings.default_on_attach(bufnr)

				-- custom mappings
				vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
				vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
			end

			-- vim.api.nvim_set_keymap("n", "ff", ":NvimTreeToggle<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "ff", ":NvimTreeFindFile<CR>", { noremap = true, silent = true })

			-- https://github.com/nvim-tree/nvim-tree.lua/pull/603
			-- https://github.com/nvim-tree/nvim-tree.lua/issues/674
			require("nvim-tree").setup {
				renderer = {
					indent_markers = {
						enable = true,
					},
					icons = {
						show = {
							folder_arrow = false,
						},
						glyphs = {
							git = {
								-- renamed = "➜",
								-- deleted = "",
								renamed = "≫",
								deleted = "≠",
							},
						}
					},
					special_files = {}
				},
				update_focused_file = {
					enable = true
				},
				filters = {
					git_ignored = false,
					dotfiles = true
				},
				actions = {
					open_file = {
						-- Closes the explorer when opening a file.
						quit_on_open = false,
					},
				},
				view = {
					adaptive_size = true,
					-- width = "16%",
					side = "left",
				},
				on_attach = on_attach,
			}

			vim.cmd([[ hi NvimTreeFolderIcon guifg=#DAA520 ]])
		end,
	},
	-- {
	--         "nvim-neo-tree/neo-tree.nvim",
	--         branch = "v3.x",
	--         cmd = "Neotree",
	--         keys = {
	--             "ff",
	--         },
	--         dependencies = {
	--             "nvim-lua/plenary.nvim",
	--             "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
	--             "MunifTanjim/nui.nvim",
	--         },
	--     config = function()
	--         require("neo-tree").setup({
	--             filesystem = {
	--                 follow_current_file = {
	--                     enabled = true,
	--                 },
	--             },
	--         })

	--         vim.cmd([[nnoremap ff :Neotree reveal<cr>]])
	--     end
	-- },
}
