-- https://github.com/nvim-lua/completion-nvim/issues/337#issuecomment-765563829
-- TODO: use https://github.com/NvChad/NvChad/blob/v2.0/lua/plugins/configs/lspconfig.lua rewrite
local enhance_attach = function(client, bufnr)
	-- highlight
	if client.server_capabilities.documentHighlightProvider then
		if vim.g.color_theme == vim.g.color_theme_dark then
			vim.cmd([[
				hi LspReferenceRead guibg=#ff8600 guifg=black gui=NONE
				hi LspReferenceText guibg=#ff8600 guifg=black gui=NONE
				hi LspReferenceWrite guibg=#ff8600 guifg=black gui=NONE
				hi NormalFloat guibg=#3e3e3e
			]])
		else
			vim.cmd([[
				hi LspReferenceRead guibg=#ffcc33 guifg=black gui=NONE
				hi LspReferenceText guibg=#ffcc33 guifg=black gui=NONE
				hi LspReferenceWrite guibg=#ffcc33 guifg=black gui=NONE
				hi Pmenu guibg=None
				hi FloatBorder gui=bold guifg=black
			]])
			-- hi NormalFloat guibg=#d9d9d9
			-- hi DiagnosticFloatingHint guifg=gray
		end
	end
	vim.cmd([[
		augroup lsp_document_highlight
		autocmd! * <buffer>
			autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
			autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
			autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
		augroup END
	]])

	-- keymap
	local opts = { buffer = bufnr, silent = true, noremap = true }
	-- TODO: https://github.com/nvim-telescope/telescope.nvim/issues/1265
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float)
	vim.keymap.set({ "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
	-- https://github.com/nvim-telescope/telescope.nvim#neovim-lsp-pickers
	-- vim.keymap.set("n", "<c-]>", ":Telescope lsp_definitions theme=get_cursor<CR>", opts)
	-- vim.keymap.set("n", "<leader>td", ":Telescope lsp_type_definitions<CR>", opts)
	-- vim.keymap.set("n", "<leader>im", ":Telescope lsp_implementations theme=ivy<CR>", opts)
	-- vim.keymap.set("n", "<leader>rf", ":Telescope lsp_references theme=ivy<CR>", opts)
	-- -- vim.keymap.set("n", "<leader>ds", ":Telescope diagnostics theme=ivy<CR>", opts)
	-- vim.keymap.set("n", "<leader>bl", ":Telescope lsp_document_symbols<CR>", opts)

	local preset_ivy = { layout = { preset = "ivy" } }
	vim.keymap.set("n", "<c-]>", function() Snacks.picker.lsp_definitions() end, opts)
	vim.keymap.set("n", "<leader>td", function() Snacks.picker.lsp_type_definitions() end, opts)
	vim.keymap.set("n", "<leader>im", function() Snacks.picker.lsp_implementations(preset_ivy) end,
		opts)
	vim.keymap.set("n", "<leader>rf", function() Snacks.picker.lsp_references(preset_ivy) end, opts)
	vim.keymap.set("n", "<leader>dw", function() Snacks.picker.diagnostics(preset_ivy) end, opts)
	vim.keymap.set("n", "<leader>db", function() Snacks.picker.diagnostics_buffer(preset_ivy) end, opts)
	vim.keymap.set("n", "<leader>bl", function() Snacks.picker.lsp_symbols() end, opts)

	-- -- disabled inlay hint
	-- if vim.lsp.inlay_hint then
	-- 	if client.server_capabilities.inlayHintProvider then
	-- 		vim.lsp.inlay_hint.enable(true)
	-- 	end
	-- end
end

return {
	{
		"neovim/nvim-lspconfig",
		event = "BufRead",
		dependencies = {
			"saghen/blink.cmp",
			{
				"folke/snacks.nvim",
				opts = {
					picker = {},
				}
			}
		},
		ft = { "go", "lua", "rust", "c", "cpp", "markdown" },
		config = function()
			-- https://neovim.io/doc/user/lsp.html
			-- https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.config()
			vim.diagnostic.config({
				-- Enable virtual text, override spacing to 4
				virtual_text = {
					severity = vim.diagnostic.severity.ERROR,
					-- severity = {
					--     min = vim.diagnostic.severity.WARN
					-- },
					spacing = 4,
					prefix = " ", --         ■ ● ▎x
				},
				signs = {
					priority = 20,
				},
				float = {
					border = "rounded", -- none,single,double
				}
			})

			-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			local signs = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "»" }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			local lspconfig = require("lspconfig")
			-- local capabilities = vim.tbl_deep_extend("force",
			--     vim.lsp.protocol.make_client_capabilities(),
			--     require("cmp_nvim_lsp").default_capabilities()
			-- )
			-- local capabilities = vim.lsp.protocol.make_client_capabilities()
			local capabilities = require("blink.cmp").get_lsp_capabilities(nil)

			-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#custom-configuration
			lspconfig.gopls.setup({
				settings = {
					gopls = {
						staticcheck = true,
						gofumpt = true,
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
				on_attach = enhance_attach,
				capabilities = capabilities,
			})

			-- https://rust-analyzer.github.io/book/other_editors.html#nvim-lsp
			lspconfig.rust_analyzer.setup({
				-- rustup toolchain install nightly --component rust-analyzer
				-- rustup component add rust-analyzer
				-- cmd = { "rustup", "run", "nightly", "rust-analyzer" },
				settings = {
					["rust-analyzer"] = {
						imports = {
							granularity = {
								group = "module",
							},
							prefix = "self",
						},
					}
				},
				on_attach = enhance_attach,
				capabilities = capabilities,
			})

			-- lspconfig.yamlls.setup({
			--     settings = {
			--         yaml = {
			--             schemas = {
			--                 -- ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
			--                 ["kubernetes"] = "/*.yaml",
			--             },
			--         },
			--     },
			--     on_attach = enhance_attach,
			--     capabilities = capabilities,
			-- })

			-- lspconfig.jsonls.setup({
			--     cmd = { "vscode-json-languageserver",  "--stdio" },
			--     on_attach = enhance_attach,
			--     capabilities = capabilities,
			-- })

			-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/clangd.lua
			lspconfig.clangd.setup({
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
				on_attach = enhance_attach,
				capabilities = capabilities,
			})

			-- -- https://github.com/MaskRay/ccls/wiki/nvim-lspconfig
			-- lspconfig.ccls.setup({
			--     cmd = { "ccls" },
			--     filetypes = { "c", "cc", "cpp", "c++", "objc", "objcpp" },
			--     root_dir = util.root_pattern("compile_commands.json", ".ccls", ".git", ".vim", ".hg"),
			--     -- signle_file_support = true,
			--     init_options = {
			--         -- compilationDatabaseDirectory = "build",
			--         -- index = {
			--         --     threads = 0,
			--         -- },
			--         -- clang = {
			--         --     excludeArgs = {
			--         --         "-frounding-math",
			--         --     },
			--         -- },
			--         cache = {
			--             -- directory = "/tmp/ccls",
			--             directory = ".ccls-cache",
			--         },
			--     },
			--     on_attach = enhance_attach,
			--     capabilities = capabilities,
			-- })

			-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
			-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/lua_ls.lua
			lspconfig.lua_ls.setup({
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
						}
					}
				},
				on_attach = enhance_attach,
				capabilities = capabilities,
			})
		end,
	}
}
