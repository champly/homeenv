local M = {}

local function go_test(command)
	if not (command.arguments and command.arguments[1]) then return false end

	local arg = command.arguments[1]
	if not arg.URI then return false end

	-- Convert file:///path/to/file to /path/to/file
	local filepath = arg.URI:gsub("^file://", "")
	-- Get directory from filepath
	local dir = filepath:match("(.*)/[^/]*$")

	local test_cmd = ""
	if arg.Benchmarks and #arg.Benchmarks > 0 then
		test_cmd = string.format("go test -benchmem -bench ^%s$ -run=^$", arg.Benchmarks[1])
	elseif arg.Tests and #arg.Tests > 0 then
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
	})
	gotest_term:toggle()

	return true
end

function M.setup(client, bufnr, opts)
	if not client.server_capabilities.codeLensProvider then
		return
	end

	local ns_id = vim.api.nvim_create_namespace("codelens-extmarks")

	-- Store codelens commands for execution
	local codelens_commands = {}

	-- Function to display codelens using extmarks
	local function display_codelens(result)
		if not result or vim.tbl_isempty(result) then return end

		-- Clear any existing extmarks to avoid duplicates
		vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
		codelens_commands[bufnr] = {}

		-- Group CodeLens by line
		local by_line = {}
		for _, lens in ipairs(result) do
			local line = lens.range.start.line
			by_line[line] = by_line[line] or {}
			table.insert(by_line[line], lens)
		end

		-- Display grouped CodeLens
		for line, lenses in pairs(by_line) do
			local lens_texts = {}
			local line_commands = {}

			for _, lens in ipairs(lenses) do
				if lens.command and lens.command.title then
					table.insert(lens_texts, lens.command.title)
					line_commands[lens.command.title] = lens.command
				end
			end

			if #lens_texts > 0 then
				-- Join all lens titles with pipe separator
				local combined_text = "▷ " .. table.concat(lens_texts, " | ")

				-- Use virtual lines above for all lines using the right configuration
				local extmark_id = vim.api.nvim_buf_set_extmark(bufnr, ns_id, line, 0, {
					virt_lines = { { { combined_text, "CodeLens" } } },
					virt_lines_above = true,
					hl_mode = "combine",
				})

				-- Store all commands for this line
				codelens_commands[bufnr][extmark_id] = line_commands
			end
		end
	end

	-- Helper to execute a command
	local function execute_command(command)
		if not command then return false end

		if command.command == "gopls.run_tests" then
			if go_test(command) then
				return true
			end
		end

		client:exec_cmd(command)
		return true
	end

	-- Execute CodeLens command
	local function execute_codelens(line)
		if not codelens_commands[bufnr] then return end

		-- Get cursor line (0-indexed for the API)
		local cursor_line = line - 1

		-- Look for extmarks at the cursor line
		local extmarks = vim.api.nvim_buf_get_extmarks(bufnr, ns_id, { cursor_line, 0 }, { cursor_line, -1 }, {})
		if #extmarks == 0 then return false end

		for _, extmark in ipairs(extmarks) do
			local id = extmark[1]
			local line_commands = codelens_commands[bufnr][id]

			if line_commands then
				-- Always use selection UI for commands regardless of count
				local items = {}
				for title, cmd in pairs(line_commands) do
					table.insert(items, {
						title = title,
						command = cmd
					})
				end

				vim.ui.select(items, {
					prompt = "CodeLens Actions",
					format_item = function(item)
						return item.title
					end,
				}, function(selected)
					if selected then
						execute_command(selected.command)
					end
				end)
				return true
			end
		end
		return false
	end

	-- -- Override the built-in codelens refresh to use our display function
	-- local orig_codelens_refresh = vim.lsp.codelens.refresh
	---@diagnostic disable-next-line: duplicate-set-field
	vim.lsp.codelens.refresh = function()
		-- Don't call the original refresh to avoid double display
		-- orig_codelens_refresh()

		-- Clear any existing CodeLens first
		vim.lsp.codelens.clear()

		local params = { textDocument = vim.lsp.util.make_text_document_params() }
		client:request("textDocument/codeLens", params, function(err, result, _, _)
			if not err and result then
				display_codelens(result)
			end
		end, bufnr)
	end

	-- Set up specific CodeLens highlights
	vim.api.nvim_set_hl(0, "CodeLens", { fg = "#7c6f64", italic = true })

	-- Add keybinding to execute CodeLens at current line
	vim.keymap.set("n", "<leader>cl", function()
		local line = vim.api.nvim_win_get_cursor(0)[1]
		execute_codelens(line)
	end, opts)

	-- Auto refresh codelens
	vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
		buffer = bufnr,
		callback = vim.lsp.codelens.refresh
	})
end

return M
