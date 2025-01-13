return {
	{
		"stevearc/conform.nvim",
		event = "BufRead",
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
				["markdown"] = { "markdownlint-cli2" },
				["markdown.mdx"] = { "markdownlint-cli2" },
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
