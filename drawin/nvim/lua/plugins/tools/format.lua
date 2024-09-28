return {
	{
		"stevearc/conform.nvim",
		opts = {
			format_on_save = {
				timeout_ms = 2000,
				lsp_fallback = true,
			},
			format_after_save = {
				lsp_format = "never",
			},
			formatters_by_ft = {
				["go"] = { "goimports", "gofumpt" },
				["json"] = { "biome" },
				["jsonc"] = { "biome" },
				["markdown"] = { "prettier" },
				["markdown.mdx"] = { "prettier" },
				["yaml"] = { "yamlfmt" },
				["toml"] = { "taplo" },
			},
			formatters = {
				biome = {
					args = {
						"format",
						"--stdin-file-path",
						"$FILENAME",
						"--config-path",
						vim.fn.stdpath("config") .. "/external/format",
					},
				}
			}
		}
	}
}
