require("nvim-tree.events").on_nvim_tree_ready(
	function()
		vim.cmd("NvimTreeRefresh")
    end
)

vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_hide_dotfiles = 1

vim.g.nvim_tree_special_files = {}

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
local list = {
	{ key = {"<CR>","o"}, cb = tree_cb("edit")},
	{ key = {"v"}, cb = tree_cb("vsplit")},
	{ key = {"s"}, cb = tree_cb("split")},
}

vim.g.nvim_tree_icons = {
	default =  '',
	symlink =  '',
	git = {
		unstaged = "✚",
		staged =  "✚",
		unmerged =  "≠",
		renamed =  "≫",
		untracked = "★",
	},
	lsp = {
		hint= "",
		info= "",
		warning= "",
		error = "",
	}
}

-- https://github.com/kyazdani42/nvim-tree.lua/pull/603
require("nvim-tree").setup {
	auto_close = true,
	update_cwd = true,
	update_focused_file = {
		enable = true,
	},
	view = {
		width = "19%",
		side = "left",
		auto_resize = true,
		mappings = {
			list = list,
		},
	}
}
