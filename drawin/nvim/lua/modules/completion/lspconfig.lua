local api = vim.api
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")
local format = require("modules.completion.format")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- -- https://github.com/neovim/neovim/issues/13946
-- function _G.reload_lsp()
--     vim.lsp.stop_client(vim.lsp.get_active_clients())
--     vim.cmd [[edit]]
-- end

-- https://github.com/neovim/nvim-lspconfig#debugging
function _G.open_lsp_log()
	vim.cmd('e' .. vim.lsp.get_log_path())
end

-- https://neovim.io/doc/user/lsp.html
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics,
	{
		-- Enable underline, use default values
		underline = true,
		-- Enable virtual text, override spacing to 4
		virtual_text = {
			spacing = 4,
			prefix = "",
			-- prefix = " ✗ ",
		},
		signs = {
			enable = true,
			priority = 20,
		},
		-- Disable a feature
		update_in_insert = false,
	}
)

-- https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
-- https://github.com/nvim-lua/completion-nvim/issues/337#issuecomment-765563829
local enhance_attach = function(client, bufnr)
	if client.resolved_capabilities.document_formatting then
		format.lsp_before_save()
	end

	-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#omnifunc
	api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	-- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	-- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	api.nvim_set_keymap('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	-- api.nvim_set_keymap('n', '<leader>im', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	-- api.nvim_set_keymap('n', '<leader>rf', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	-- api.nvim_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	-- api.nvim_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

	-- https://github.com/nvim-telescope/telescope.nvim#neovim-lsp-pickers
	api.nvim_set_keymap('n', '<leader>im', ':Telescope lsp_implementations theme=ivy<CR>', opts)
	-- api.nvim_set_keymap('n', '<leader>im', ':lua require("telescope.builtin").lsp_implementations(require("telescope.themes").get_dropdown({layout_config = { width = 0.99 }}))<CR>', opts)
	api.nvim_set_keymap('n', '<leader>rf', ':Telescope lsp_references theme=ivy<CR>', opts)
	api.nvim_set_keymap("n", "<leader>ca", ":Telescope lsp_code_actions theme=ivy<CR>", opts)
	api.nvim_set_keymap("n", "<leader>ds", ":Telescope diagnostics theme=ivy<CR>", opts)
	api.nvim_set_keymap("n", "<leader>bl", ":Telescope lsp_document_symbols theme=ivy<CR>", opts)

	-- -- lspsaga keymap
	-- -- https://github.com/tami5/lspsaga.nvim/blob/main/lua/lspsaga/command.lua#L11
	-- api.nvim_set_keymap("n", "gx", "<cmd>Lspsaga code_action<cr>", opts)
	-- api.nvim_set_keymap("x", "gx", ":<c-u>Lspsaga range_code_action<cr>", opts)
	-- -- api.nvim_set_keymap("n", "K",  "<cmd>Lspsaga hover_doc<cr>", opts)
	-- api.nvim_set_keymap("n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)
	-- api.nvim_set_keymap("n", "<c-j>", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
	-- api.nvim_set_keymap("n", "<c-k>", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
	-- api.nvim_set_keymap("n", "<leader>gd", "<cmd>Lspsaga preview_definition<cr>", opts)
	-- api.nvim_set_keymap("n", "<leader>rf", "<cmd>lua require'lspsaga.provider'.lsp_finder()<cr>", opts)
	-- api.nvim_set_keymap("n", "<leader>rn", "<cmd>Lspsaga rename<cr>", opts)
	-- -- api.nvim_set_keymap("n", "<leader>im", "<cmd>Lspsaga implement<cr>", opts)
	-- -- api.nvim_set_keymap("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>", opts)
	-- -- api.nvim_set_keymap("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>", opts)

	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec([[
			" hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
			hi LspReferenceRead guibg=#ff8600 guifg=black
			hi LspReferenceText guibg=#ff8600 guifg=black
			hi LspReferenceWrite guibg=#ff8600 guifg=black
			augroup lsp_document_highlight
			autocmd! * <buffer>
			autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
			autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			augroup END
		]], false)
	end

	require "lsp_signature".on_attach({
		bind = true, -- This is mandatory, otherwise border config won't get registered.
		handler_opts = {
			border = "rounded"
		}
	}, bufnr)
end

-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#custom-configuration
lspconfig.gopls.setup {
	cmd = {"gopls", "serve"},
	filetypes = {"go", "gomod", "gotmpl"},
	root_dir = function(fname)
		-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/gopls.lua
		-- return util.root_pattern("go.work")(fname) or util.root_pattern("go.mod", ".git", ".vim/", ".hg/")(fname)
		return util.root_pattern 'go.work'(fname) or util.root_pattern('go.mod', '.git')(fname)
	end,
	settings = {
		gopls = {
			usePlaceholders = false,
			codelenses = {
				gc_details = true,
			},
			analyses = {
				fieldalignment = false
			},
			allowModfileModifications = true,
			experimentalWorkspaceModule = false,
		}
	},
	on_attach = enhance_attach,
	capabilities = capabilities,
}

lspconfig.rust_analyzer.setup {
	settings = {
		["rust-analyzer"] = {
			assist = {
				importGranularity = "module",
				importPrefix = "by_self",
			},
			inlayHints = {
				enable = true,
				chainingHints = true,
				maxLength = 25,
				parameterHints = true,
				typeHints = true,
				hideNamedConstructorHints = false,
				typeHintsSeparator = "‣",
				typeHintsWithVariable = true,
				chainingHintsSeparator = "‣",
			},
			-- cargo = {
			--     loadOutDirsFromCheck = true
			-- },
			procMacro = {
				enable = true
			},
		}
	},
	on_attach = enhance_attach,
	capabilities = capabilities,
}

lspconfig.yamlls.setup {
	settings = {
		yaml = {
			schemas = {
				-- ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
				["kubernetes"] = "/*.yaml",
			},
		},
	},
	on_attach = enhance_attach,
	capabilities = capabilities,
}

-- lspconfig.jsonls.setup {
--     cmd = { "vscode-json-languageserver",  "--stdio" },
--     on_attach = enhance_attach,
--     capabilities = capabilities,
-- }

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

-- -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
-- local sumneko_root_path = "/Users/champly/.config/coc/extensions/coc-lua-data/sumneko-lua-ls"
-- local sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"

lspconfig.sumneko_lua.setup {
	-- cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {'vim'},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
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
