local config = {}

function config.nvim_lsp()
	require("modules.completion.lspconfig")
end

function config.nvim_cmp()
	-- require("cmp").setup {
	-- }
	require("cmp")
end

function config.telescope()
	if not packer_plugins["plenary.nvim"].loaded then
		vim.cmd [[packadd plenary.nvim]]
		vim.cmd [[packadd popup.nvim]]
		vim.cmd [[packadd telescope-fzy-native.nvim]]
	end

	-- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/config.lua
	require('telescope').setup {
		defaults = {
			prompt_prefix = '🔭 ',
			selection_caret = " ",
			sorting_strategy = 'ascending',
			layout_strategy = "horizontal",
			winblend = 30,
			layout_config = {
				prompt_position = 'top',
				height = 0.8,
				width = 0.8,
			},
		},
		extensions = {
			fzy_native = {
				override_generic_sorter = false,
				override_file_sorter = true,
			}
		}
	}

	require('telescope').load_extension('fzy_native')
	require('telescope').load_extension('gosource')
	require('telescope').load_extension('dotfiles')

	vim.api.nvim_set_keymap("n", "<leader>fb", ":Telescope buffers<cr>", {})
	vim.api.nvim_set_keymap("n", "<leader>fs", ":Telescope gosource<cr>", {})
	vim.api.nvim_set_keymap("n", "<leader>fd", ":Telescope dotfiles<cr>", {})
end

return config
