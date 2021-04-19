-- local lang = {}
-- local conf = require('modules.lang.config')

-- lang['nvim-treesitter/nvim-treesitter'] = {
--     event = 'BufRead',
--     after = 'telescope.nvim',
--     config = conf.nvim_treesitter
-- }

-- lang['nvim-treesitter/nvim-treesitter-textobjects'] = {
--     after = 'nvim-treesitter'
-- }

-- return lang

require("nvim-treesitter.configs").setup {
	ensure_installed = "maintained",
	highlight = {
		enable = true, -- false will disable the whole extension
	},
	-- textobjects = {
	--     select = {
	--         enable = true,
	--         keymaps = {
	--             ["<leader>af"] = "@function.outer",
	--             ["<leader>if"] = "@function.inner",
	--             ["<leader>ac"] = "@class.outer",
	--             ["<leader>ic"] = "@class.inner",
	--         },
	--     },
	-- },
}
