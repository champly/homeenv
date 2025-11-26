return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup({
				-- ensure_installed = "all",
				ensure_installed = {
					"lua",
					"go",
					"gomod",
					"gosum",
					"gowork",
					"c",
					"cpp",
					"rust",
					"vim",
					"proto",
					"dockerfile",
					"markdown",
					"markdown_inline",
					"json",
					"jsonc",
					"yaml",
					"bash",
					"html",
					"python",
					"diff", -- for aznhe21/actions-preview.nvim
					"kdl",
					"nix",
					"nickel",
				},
				highlight = {
					enable = true, -- false will disable the whole extension
					disable = function(_, buf)
						return vim.api.nvim_buf_line_count(buf) > 6000
					end,
				},
			})
		end,
	}
}
