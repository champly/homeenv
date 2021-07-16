require("nvim-tree.events").on_nvim_tree_ready(
	function()
		vim.cmd("NvimTreeRefresh")
    end
)

vim.g.nvim_tree_auto_close = 1
vim.g.nvim_tree_width = 46
vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_hide_dotfiles = 1
vim.g.nvim_tree_auto_resize = 1
vim.g.nvim_tree_update_cwd = 1

vim.g.nvim_tree_special_files = {}

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
vim.g.nvim_tree_bindings = {
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
}
