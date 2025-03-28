-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#custom-configuration
return {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	settings = {
		gopls = {
			codelenses = {
				test = true,
			},
			staticcheck = true,
			gofumpt = true,
			-- semanticTokens = true,
			-- analyses = {
			--     -- https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
			-- },
			-- https://github.com/golang/tools/blob/master/gopls/doc/features/diagnostics.md
			pullDiagnostics = true,
			-- ["local"] = "github.com/champly",
			-- https://github.com/golang/tools/blob/master/gopls/doc/inlayHints.md
			-- hints = {
			-- 	assignVariableTypes = true,
			-- 	compositeLiteralFields = true,
			-- 	compositeLiteralTypes = true,
			-- 	constantValues = true,
			-- 	functionTypeParameters = true,
			-- 	parameterNames = true,
			-- 	rangeVariableTypes = true,
			-- },
		}
	},
}
