-- https://github.com/nvim-lua/completion-nvim/issues/337#issuecomment-765563829
-- TODO: use https://github.com/NvChad/NvChad/blob/v2.0/lua/plugins/configs/lspconfig.lua rewrite
local enhance_attach = function(client, bufnr)
	-- highlight
	if client.server_capabilities.documentHighlightProvider then
		if vim.g.color_theme == vim.g.color_theme_dark then
			vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "#ff8600", fg = "black" })
			vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "#ff8600", fg = "black" })
			vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "#ff8600", fg = "black" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#3e3e3e" })
		else
			vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "#ffcc33", fg = "black" })
			vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "#ffcc33", fg = "black" })
			vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "#ffcc33", fg = "black" })
			vim.api.nvim_set_hl(0, "Pmenu", { bg = "None" })
			vim.api.nvim_set_hl(0, "FloatBorder", { fg = "black", bold = true })
			-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#d9d9d9" })
			-- vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { fg = "gray" })
		end
	end

	-- lsp_document_highlight
	vim.api.nvim_create_autocmd("CursorHold", { callback = vim.lsp.buf.document_highlight })
	vim.api.nvim_create_autocmd("CursorHoldI", { callback = vim.lsp.buf.document_highlight })
	vim.api.nvim_create_autocmd("CursorMoved", { callback = vim.lsp.buf.clear_references })

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

	local preset_default = { jump = { reuse_win = false } }
	local preset_ivy = { layout = { preset = "ivy" }, jump = { reuse_win = false } }
	vim.keymap.set("n", "<c-]>", function() Snacks.picker.lsp_definitions(preset_default) end, opts)
	vim.keymap.set("n", "<leader>td", function() Snacks.picker.lsp_type_definitions(preset_default) end, opts)
	vim.keymap.set("n", "<leader>im", function() Snacks.picker.lsp_implementations(preset_ivy) end, opts)
	vim.keymap.set("n", "<leader>rf", function() Snacks.picker.lsp_references(preset_ivy) end, opts)
	vim.keymap.set("n", "<leader>dw", function() Snacks.picker.diagnostics(preset_ivy) end, opts)
	vim.keymap.set("n", "<leader>db", function() Snacks.picker.diagnostics_buffer(preset_ivy) end, opts)
	vim.keymap.set("n", "<leader>bl", function() Snacks.picker.lsp_symbols(preset_default) end, opts)

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
		enabled = false,
		ft = { "go", "lua", "rust", "c", "cpp", "markdown" },
		config = function()
			-- https://neovim.io/doc/user/lsp.html
			-- https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.config()
			vim.diagnostic.config({
				underline = {
					severity = vim.diagnostic.severity.ERROR,
				},
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
						-- -- https://rust-analyzer.github.io/book/configuration.html#configuration
						-- semanticHighlighting = {
						-- 	operator = {
						-- 		specialization = {
						-- 			enable = true,
						-- 		}
						-- 	},
						-- 	punctuation = {
						-- 		enable = true,
						-- 		separate = {
						-- 			macro = {
						-- 				bang = true,
						-- 			}
						-- 		},
						-- 		specialization = {
						-- 			enable = true,
						-- 		}
						-- 	}
						-- }
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
