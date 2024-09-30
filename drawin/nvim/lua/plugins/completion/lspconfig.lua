local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

return {
	{
		"neovim/nvim-lspconfig",
		event = "BufRead",
		dependencies = {
			"telescope.nvim",
		},
		ft = { "go", "lua", "rust", "c", "cpp", "markdown" },
		config = function()
			-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities(),
				{
					textDocument = {
						foldRange = {
							dynamicRegistration = false,
							lineFoldingOnly = true,
						},
					},
					-- FIXME: workaround for https://github.com/neovim/neovim/issues/28058
					workspace = {
						didChangeWatchedFiles = {
							dynamicRegistration = false,
							relativePatternSupport = false,
						},
					},
				}
			)

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
					prefix = "",
				},
				signs = {
					priority = 20,
				},
			})

			-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			local signs = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "»" }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			-- https://github.com/nvim-lua/completion-nvim/issues/337#issuecomment-765563829
			-- TODO: use https://github.com/NvChad/NvChad/blob/v2.0/lua/plugins/configs/lspconfig.lua rewrite
			local enhance_attach = function(client, bufnr)
				-- Set autocommands conditional on server_capabilities
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
				hi NormalFloat guibg=#d9d9d9
				hi DiagnosticFloatingHint guifg=gray
			]])
					end

					vim.cmd([[
			augroup lsp_document_highlight
			autocmd! * <buffer>
				autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
				autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			augroup END
		]])
				end

				require("lsp_signature").on_attach({
					bind = true, -- This is mandatory, otherwise border config won't get registered.
					handler_opts = {
						border = "rounded"
					}
				}, bufnr)

				if vim.lsp.inlay_hint then
					if client.server_capabilities.inlayHintProvider then
						vim.lsp.inlay_hint.enable(true)
					end
				end
			end

			-- -- Global mappings.
			-- -- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float)
			-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
			-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
			-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			-- https://github.com/neovim/nvim-lspconfig#suggested-configuration
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf, silent = true, noremap = true }

					-- TODO: https://github.com/nvim-telescope/telescope.nvim/issues/1265
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
					-- https://github.com/nvim-telescope/telescope.nvim#neovim-lsp-pickers
					vim.keymap.set("n", "<c-]>", ":Telescope lsp_definitions theme=get_cursor<CR>", opts)
					vim.keymap.set("n", "<leader>td", ":Telescope lsp_type_definitions<CR>", opts)
					vim.keymap.set("n", "<leader>im", ":Telescope lsp_implementations theme=ivy<CR>", opts)
					vim.keymap.set("n", "<leader>rf", ":Telescope lsp_references theme=ivy<CR>", opts)
					vim.keymap.set("n", "<leader>ds", ":Telescope diagnostics theme=ivy<CR>", opts)
					vim.keymap.set("n", "<leader>bl", ":Telescope lsp_document_symbols<CR>", opts)
				end,
			})

			-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#custom-configuration
			lspconfig.gopls.setup {
				cmd = { "gopls", "-mode=stdio" },
				filetypes = { "go", "gomod", "gotmpl" },
				root_dir = function(fname)
					-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/gopls.lua
					return util.root_pattern("go.work")(fname) or util.root_pattern("go.mod", ".git")(fname)
				end,
				settings = {
					gopls = {
						usePlaceholders = false,
						codelenses = {
							gc_details = true,
						},
						staticcheck = true,
						gofumpt = true,
						analyses = {
							-- https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
							fieldalignment = true
						},
						-- ["local"] = "github.com/champly",
						-- https://github.com/golang/tools/blob/master/gopls/doc/inlayHints.md
						-- hints = {
						--     assignVariableTypes = true,
						--     compositeLiteralFields = true,
						--     compositeLiteralTypes = true,
						--     constantValues = true,
						--     functionTypeParameters = true,
						--     parameterNames = true,
						--     rangeVariableTypes = true,
						-- },
					}
				},
				on_attach = enhance_attach,
				capabilities = capabilities,
			}

			-- https://rust-analyzer.github.io/manual.html#nvim-lsp
			lspconfig.rust_analyzer.setup {
				-- rustup toolchain install nightly --component rust-analyzer
				-- cmd = { "rustup", "run", "stable", "rust-analyzer" },
				cmd = { "rustup", "run", "nightly", "rust-analyzer" },
				-- cmd = { "rust-analyzer" },
				settings = {
					["rust-analyzer"] = {
						imports = {
							granularity = {
								group = "module",
							},
							prefix = "self",
						},
						cargo = {
							buildScripts = {
								enable = true,
							},
						},
						procMacro = {
							enable = true
						},
						-- inlayHints = {
						--     enable = true,
						--     chainingHints = true,
						--     maxLength = 25,
						--     parameterHints = true,
						--     typeHints = true,
						--     hideNamedConstructorHints = false,
						--     typeHintsSeparator = "‣",
						--     typeHintsWithVariable = true,
						--     chainingHintsSeparator = "‣",
						-- },
					}
				},
				on_attach = enhance_attach,
				capabilities = capabilities,
			}

			-- lspconfig.yamlls.setup {
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
			-- }

			-- lspconfig.jsonls.setup {
			--     cmd = { "vscode-json-languageserver",  "--stdio" },
			--     on_attach = enhance_attach,
			--     capabilities = capabilities,
			-- }

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
			-- lspconfig.ccls.setup {
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
			-- }

			-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
			local runtime_path = vim.split(package.path, ';')
			table.insert(runtime_path, "lua/?.lua")
			table.insert(runtime_path, "lua/?/init.lua")
			local root_files = {
				".luarc.json",
				".luacheckrc",
				".stylua.toml",
				"selene.toml",
				"init.vim",
			}
			lspconfig.lua_ls.setup {
				-- cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
				root_dir = function(fname)
					return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
				end,
				settings = {
					Lua = {
						runtime = {
							-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
							-- Setup your lua path
							path = runtime_path,
						},
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = { "vim" },
							enable = true,
						},
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = vim.api.nvim_get_runtime_file("", true),
							-- library = vim.list_extend({ [vim.fn.expand("$VIMRUNTIME/lua")] = true }, {}),
						},
						-- Do not send telemetry data containing a randomized but unique identifier
						telemetry = {
							enable = false,
						},
					},
				},
				on_attach = enhance_attach,
				capabilities = capabilities,
			}
		end,
	}
}
