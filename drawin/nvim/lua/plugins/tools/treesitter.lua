return {
	{
		"romus204/tree-sitter-manager.nvim",
		opts = {
			-- builtin: c, lua, vim, vimdoc, query, markdown, markdown_inline
			ensure_installed = {
				"go",
				"gomod",
				"gosum",
				"gowork",
				"cpp",
				"rust",
				"proto",
				"dockerfile",
				"json",
				"yaml",
				"bash",
				"html",
				"python",
				"diff", -- for aznhe21/actions-preview.nvim
				"kdl",
				"nix",
				"nickel",
			},
		},
	},
}
