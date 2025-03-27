-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/clangd.lua
return {
	cmd = {
		"clangd",
		-- "--background-index",
		-- "--suggest-missing-includes",
		-- "--clang-tidy",
		-- "--header-insertion=iwyu",
	},
	-- filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	single_file_support = true,
}
