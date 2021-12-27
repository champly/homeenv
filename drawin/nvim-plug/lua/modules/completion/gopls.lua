-- -- " https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-v050
-- nvim_lsp = require "lspconfig"
-- nvim_lsp.gopls.setup {
--     cmd = {"gopls", "--mode=stdio"},
--     rootdir = {},
--     filetype = {"go"},
--     settings = {
--         gopls = {
--             usePlaceholders = true,
--             codelenses = {
--                 gc_details = true,
--             },
--         },
--     },
--     on_attach = require'completion'.on_attach
-- }

-- -- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#imports
-- function goimports(timeoutms)
--     local context = { source = { organizeImports = true } }
--     vim.validate { context = { context, "t", true } }

--     local params = vim.lsp.util.make_range_params()
--     params.context = context

--     local method = "textDocument/codeAction"
--     local resp = vim.lsp.buf_request_sync(0, method, params, timeoutms)
--     if resp and resp[1] then
--         local result = resp[1].result
--         if result and result[1] then
--             local edit = result[1].edit
--             vim.lsp.util.apply_workspace_edit(edit)
--         end
--     end

--     vim.lsp.buf.formatting()
-- end

-- autocmd BufWritePre *.go lua goimports(1000)

-- -- " https://neovim.io/doc/user/lsp.html
-- nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
-- nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
-- nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
-- nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
-- nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
-- nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
-- nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
-- nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
-- nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

-- let g:lsp_signs_error = {'text': '✗'}
-- let g:lsp_signs_warning = {'text': '!'}

-- -- " https://github.com/neovim/nvim-lspconfig/issues/411#issue-744588783
-- nvim_lsp = require "lspconfig"
-- nvim_lsp.gopls.setup {
--     cmd = {"gopls"},
--     settings = {
--         gopls = {
--             analyses = {
--                 unusedparams = true,
--             },
--             staticcheck = true,
--         },
--     },
-- }

-- augroup LSP | au!
--     autocmd BufWritePre *.json,*.yaml lua vim.lsp.buf.formatting_sync(nil, 1000)
-- augroup END

-- let g:lsp_diagnostics_enabled = 1

-- -- show diagnostic signs
-- let g:lsp_signs_enabled = 1
-- let g:lsp_signs_error = {'text': '✗'}
-- let g:lsp_signs_warning = {'text': '!'}
-- let g:lsp_highlights_enabled = 0

-- -- Do not use virtual text, they are far too obtrusive.
-- let g:lsp_virtual_text_enabled = 0
-- -- echo a diagnostic message at cursor position
-- let g:lsp_diagnostics_echo_cursor = 0
-- -- show diagnostic in floating window
-- let g:lsp_diagnostics_float_cursor = 1
-- -- whether to enable highlight a symbol and its references
-- let g:lsp_highlight_references_enabled = 1
-- let g:lsp_preview_max_width = 80
