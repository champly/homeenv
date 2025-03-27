-- https://rust-analyzer.github.io/book/other_editors.html#nvim-lsp
return {
	-- rustup toolchain install nightly --component rust-analyzer
	-- rustup component add rust-analyzer
	cmd = { "rustup", "run", "nightly", "rust-analyzer" },
	filetypes = { "rust" },
	settings = {
		["rust-analyzer"] = {
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			-- -- https://rust-analyzer.github.io/book/configuration.html#configuration
			-- semanticHighlighting = {
			-- 	operator = {
			-- 		specialization = {
			-- 			enable = true,
			-- 		}
			-- 	},
			-- 	punctuation = {
			-- 		enable = true,
			-- 		separate = {
			-- 			macro = {
			-- 				bang = true,
			-- 			}
			-- 		},
			-- 		specialization = {
			-- 			enable = true,
			-- 		}
			-- 	}
			-- }
		}
	},
}
