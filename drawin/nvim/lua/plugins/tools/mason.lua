return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			{
				"folke/snacks.nvim",
				opts = {
					input = {
						win = {
							relative = "cursor",
							row = -3,
							col = 0,
						}
					},
					picker = {},
				}
			}
		},
		opts = {
			ensure_installed = {
				-- debug: rust/cpp
				"codelldb",
				-- json
				"biome",
				"prettier",
				-- lua
				"lua-language-server",
				-- c/c++
				"clangd",
				-- yaml
				"yamlfmt",
				-- go
				"goimports",
				"gofumpt",
				"gomodifytags",
				"delve",
				-- python
				"pyright",
				-- toml
				"taplo",
				-- markdown
				"markdownlint-cli2",
			},
		},
		config = function(_, opts)
			-- https://github.com/williamboman/mason.nvim/issues/1309#issuecomment-1555018732
			require("mason").setup(opts)
			local registry = require "mason-registry"
			registry.refresh(function()
				for _, pkg_name in ipairs(opts.ensure_installed) do
					local pkg = registry.get_package(pkg_name)
					if not pkg:is_installed() then
						pkg:install()
					end
				end
			end)
		end,
	}
}
