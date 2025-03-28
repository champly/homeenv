-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/lua_ls.lua
return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT"
			},
			diagnostics = {
				globals = {
					"vim",
					"require"
				},
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME
				},
			},
			completion = {
				callSnippet = "Replace"
			},
			-- codeLens = {
			-- 	enable = true,
			-- }
		}
	},
}
