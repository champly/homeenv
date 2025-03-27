-- https://github.com/MaskRay/ccls/wiki/nvim-lspconfig
return {
	cmd = { "ccls" },
	filetypes = { "c", "cc", "cpp", "c++", "objc", "objcpp" },
	signle_file_support = true,
	init_options = {
		-- compilationDatabaseDirectory = "build",
		-- index = {
		--     threads = 0,
		-- },
		-- clang = {
		--     excludeArgs = {
		--         "-frounding-math",
		--     },
		-- },
		cache = {
			-- directory = "/tmp/ccls",
			directory = ".ccls-cache",
		},
	},
}
