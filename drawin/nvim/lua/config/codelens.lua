local M = {}

-- CodeLens highlight
vim.api.nvim_set_hl(0, "LspCodeLens", { fg = "#7c6f64", italic = true })
vim.api.nvim_set_hl(0, "LspCodeLensSeparator", { fg = "#7c6f64", italic = true })

local function go_test(command)
	if not (command.arguments and command.arguments[1]) then return false end

	local arg = command.arguments[1]
	if not arg.URI then return false end

	local filepath = vim.uri_to_fname(arg.URI)
	local dir = filepath:match("(.*)/[^/]*$")

	local test_cmd = ""
	if arg.Benchmarks and arg.Benchmarks ~= vim.NIL and #arg.Benchmarks > 0 then
		test_cmd = string.format("go test -benchmem -bench ^%s$ -run=^$", arg.Benchmarks[1])
	elseif arg.Tests and arg.Tests ~= vim.NIL and #arg.Tests > 0 then
		test_cmd = string.format("go test -v -cover -run ^%s$", arg.Tests[1])
	else
		return false
	end

	local Terminal = require("toggleterm.terminal").Terminal
	local gotest_term = Terminal:new({
		cmd = test_cmd,
		dir = dir,
		auto_scroll = false,
		close_on_exit = false,
		on_exit = function(term)
			vim.schedule(function()
				if term.bufnr and vim.api.nvim_buf_is_valid(term.bufnr) then
					local wins = vim.fn.win_findbuf(term.bufnr)
					for _, win in ipairs(wins) do
						vim.api.nvim_win_call(win, function()
							vim.cmd("stopinsert")
						end)
					end
					local close = function()
						if term.bufnr and vim.api.nvim_buf_is_valid(term.bufnr) then
							vim.api.nvim_buf_delete(term.bufnr, { force = true })
						end
					end
					vim.keymap.set("n", "q", close, { buffer = term.bufnr, nowait = true })
					vim.keymap.set("n", "<Esc>", close, { buffer = term.bufnr, nowait = true })
				end
			end)
		end,
	})
	gotest_term:toggle()

	return true
end

function M.setup(client, bufnr, opts)
	local methods = vim.lsp.protocol.Methods
	if not client:supports_method(methods.textDocument_codeLens) then
		return
	end

	vim.lsp.codelens.enable(true, { bufnr = bufnr })

	-- Intercept gopls.run_tests to run in toggleterm
	if client.name == "gopls" then
		local original_exec_cmd = client.exec_cmd
		client.exec_cmd = function(self, command, ctx)
			if command.command == "gopls.run_tests" and go_test(command) then
				return
			end
			return original_exec_cmd(self, command, ctx)
		end
	end

	-- Add keybinding to run CodeLens at current line (built-in default is grx)
	vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, opts)
end

return M