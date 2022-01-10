local api = vim.api
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")
local global = require("core.global")
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
vim.lsp.diagnostic.on_publish_diagnostics, {
	-- Enable underline, use default values
	underline = true,
	-- Enable virtual text, override spacing to 4
	virtual_text = true,
	signs = {
		enable = true,
		priority = 20,
	},
	-- Disable a feature
	update_in_insert = false,
})

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
	api.nvim_set_keymap('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	api.nvim_set_keymap('n', '<leader>im', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	api.nvim_set_keymap('n', '<leader>rf', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	api.nvim_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	api.nvim_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

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

	-- require('completion').on_attach(client)
end

-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#custom-configuration
lspconfig.gopls.setup {
	-- cmd = {"gopls", "serve"},
	cmd = {"gopls"},
	filetypes = {"go", "gomod", "gotmpl"},
	root_dir = function(fname)
		-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/gopls.lua
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
	on_attach = enhance_attach,
	capabilities = capabilities,
}
