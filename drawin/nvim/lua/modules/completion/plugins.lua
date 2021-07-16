-- https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
-- https://github.com/nvim-lua/completion-nvim/issues/337#issuecomment-765563829
local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap=true, silent=true }
	buf_set_keymap('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', '<leader>im', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<leader>rf', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

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

	require('completion').on_attach(client)
end

lspconfig.gopls.setup {
	-- cmd = {"gopls", "--remote=auto"},
	cmd = {"gopls"},
	filetypes = {"go", "gomod"};
	root_dir = util.root_pattern("go.mod", ".git/");
	on_attach = on_attach,
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
			experimentalWorkspaceModule = true,
		}
	}
}
