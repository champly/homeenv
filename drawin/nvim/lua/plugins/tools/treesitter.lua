return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function ()
			-- builtin: c, lua, vim, vimdoc, query, markdown, markdown_inline
			require("nvim-treesitter").install({
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
				"nickel"
			})

			-- Enable treesitter highlighting via FileType autocmd
			vim.api.nvim_create_autocmd("FileType", {
				callback = function (args)
					local buf = args.buf
					if vim.api.nvim_buf_line_count(buf) > 6000 then
						return
					end
					pcall(vim.treesitter.start, buf)
				end
			})
		end
	}
}
