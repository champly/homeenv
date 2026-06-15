local module_cache = {}

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre", "BufReadPost" },
	opts = {
		format_on_save = {
			timeout_ms = 2000,
			lsp_fallback = true
		},
		format_after_save = {
			lsp_format = "never"
		},
		formatters_by_ft = {
			["go"] = { "goimports", "gofumpt" },
			["json"] = { "biome" },
			["jsonc"] = { "biome" },
			["markdown"] = { "markdownlint-cli2" },
			["markdown.mdx"] = { "markdownlint-cli2" },
			["yaml"] = { "yamlfmt" },
			["toml"] = { "taplo" }
		},
		formatters = {
			biome = {
				args = { "format", "--stdin-file-path", "$FILENAME", "--config-path",
					vim.fn.stdpath("config") .. "/external/format" }
			},
			goimports = {
				prepend_args = function(self, ctx)
					if vim.g.go_import_without_local then
						return {}
					end

					-- fix with issue: https://github.com/golang/go/issues/40660
					local cwd = vim.fs.root(ctx.buf, { "go.mod" }) or vim.fn.getcwd()
					if module_cache[cwd] == nil then
						local r = vim.system({ "go", "list", "-m" }, { cwd = cwd, text = true }):wait()
						module_cache[cwd] = (r.code == 0) and vim.trim(r.stdout or "") or ""
					end
					local m = module_cache[cwd]
					return m ~= "" and { "-local", m } or {}
				end
			}
		}
	}
}
