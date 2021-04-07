-- local configs = require 'lspconfig/configs'
-- local util = require 'lspconfig/util'

-- configs.gopls = {
--     default_config = {
--         cmd = {"gopls"};
--         filetypes = {"go", "gomod"};
--         root_dir = util.root_pattern("go.mod", ".git");
--     };
--     -- on_new_config = function(new_config) end;
--     -- on_attach = function(client, bufnr) end;
--     docs = {
--         description = [[
-- https://github.com/golang/tools/tree/master/gopls
-- Google's lsp server for golang.
-- ]];
--         default_config = {
--             root_dir = [[root_pattern("go.mod", ".git")]];
--         }
--     }
-- }

local lspconfig = require "lspconfig"
local util = require 'lspconfig/util'

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap=true, silent=true }
	buf_set_keymap('n', '<c-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', '<leader>im', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<leader>rf', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	-- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	-- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	-- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	-- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	-- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	-- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	-- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	-- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

	-- -- Set some keybinds conditional on server capabilities
	-- if client.resolved_capabilities.document_formatting then
	--     buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	-- elseif client.resolved_capabilities.document_range_formatting then
	--     buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	-- end

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
end

lspconfig.gopls.setup {
	-- cmd = {"gopls", "--remote=auto"},
	cmd = {"gopls"},
	filetypes = {"go", "gomod"};
	root_dir = util.root_pattern("go.mod", ".git");
	-- on_attach = enhance_attach,
	on_attach = on_attach,
	-- capabilities = capabilities,
	init_options = {
		usePlaceholders = false,
		-- codelense = {
		--     gc_details = true,
		-- },
		-- analysis = {
		--     fieldalignment = false
		-- },
		-- allowModfileModifications = true
	}
}
