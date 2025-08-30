-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#emmylua_ls
-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/emmylua_ls.lua
-- https://github.com/EmmyLuaLs/emmylua-analyzer-rust/blob/main/docs/config/emmyrc_json_EN.md
return {
	cmd = { "emmylua_ls" },
	filetypes = { "lua" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			workspace = {
				library = {
					vim.env.VIMRUNTIME
				},
				-- library = vim.api.nvim_get_runtime_file('', true),
			},
		}
	},
}
