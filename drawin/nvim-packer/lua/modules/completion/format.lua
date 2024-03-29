local format = {}
local tool = require("utils.tool")

function format.lsp_before_save()
	local defs = {}
	local ext = vim.fn.expand("%:e")
	table.insert(defs, { "BufWritePre", "*." .. ext, "lua vim.lsp.buf.format(nil, 1000)" })
	if ext == "go" then
		-- autocmd BufWritePre *.go lua goimports(1000)
		table.insert(defs, { "BufWritePre", "*.go", "lua require('modules.completion.format').OrgImports(1000)" })
	end
	tool.nvim_create_augroups({ lsp_before_save = defs })
end

-- Synchronously organise (Go) imports. Taken from
-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#imports
function format.OrgImports(wait_ms)
	local params = vim.lsp.util.make_range_params()
	params.context = { only = { "source.organizeImports" } }
	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
	for _, res in pairs(result or {}) do
		for _, r in pairs(res.result or {}) do
			if r.edit then
				vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
			else
				vim.lsp.buf.execute_command(r.command)
			end
		end
	end
end

return format
