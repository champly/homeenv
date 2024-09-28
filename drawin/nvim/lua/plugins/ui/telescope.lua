return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	event = "BufRead",
	dependencies = {
		{ "nvim-telescope/telescope-live-grep-args.nvim" },
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-fzy-native.nvim" },
		{ "nvim-lua/popup.nvim" },
	},
	config = function()
		-- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/config.lua
		require("telescope").setup({
			defaults = {
				prompt_prefix = "🔭 ",
				selection_caret = " ",
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				layout_config = {
					prompt_position = "top",
					height = 0.8,
					scroll_speed = 6,
				},
				dynamic_preview_title = true,
				-- default mapping: https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua#L133
				mappings = {
					i = {
						["<C-j>"] = "preview_scrolling_left",
						["<C-f>"] = { "<Right>", type = "command" },
					},
				},
			},
			extensions = {
				fzy_native = {
					override_generic_sorter = false,
					override_file_sorter = true,
				},
				live_grep_args = {
					auto_quoting = true, -- enable/disable auto-quoting
				}
			}
		})

		require("telescope").load_extension("fzy_native")
		require("telescope").load_extension("gosource")
		require("telescope").load_extension("dotfiles")
		require("telescope").load_extension("nvimdap")
		require("telescope").load_extension("live_grep_args")

		vim.api.nvim_set_keymap("n", "<leader>fb", ":Telescope buffers<cr>", {})
		vim.api.nvim_set_keymap("n", "<leader>fh", ":Telescope oldfiles<cr>", {})
		vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<cr>", {})
		vim.api.nvim_set_keymap("n", "<leader>fw", ":Telescope live_grep<cr>", {})
		vim.api.nvim_set_keymap("n", "<leader>rg",
			":lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>",
			{})
		vim.api.nvim_set_keymap("n", "<leader>fd", ":Telescope dotfiles<cr>", {})
		vim.api.nvim_set_keymap("n", "<leader>fs", ":Telescope gosource<cr>", {})
		vim.api.nvim_set_keymap("n", "<leader>dt", ":Telescope nvimdap<cr>", {})
		vim.api.nvim_set_keymap("n", "<leader>gl", ":Telescope git_bcommits<cr>", {})
	end
}
