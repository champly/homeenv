-- Translate using Ollama with HY-MT model
-- https://huggingface.co/tencent/HY-MT1.5-1.8B-GGUF
--
-- Setup Ollama model:
-- echo 'FROM hf.co/tencent/HY-MT1.5-1.8B-GGUF:Q8_0
-- TEMPLATE """<｜hy_begin▁of▁sentence｜>{{ if .System }}{{ .System }}<｜hy_place▁holder▁no▁3｜>{{ end }}{{ if .Prompt }}<｜hy_User｜>{{ .Prompt }}{{ end }}<｜hy_Assistant｜>"""' > /tmp/Modelfile
-- ollama create hy-mt -f /tmp/Modelfile

local M = {}

local function get_visual_selection()
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local srow, scol = start_pos[2], start_pos[3]
	local erow, ecol = end_pos[2], end_pos[3]

	local lines = vim.api.nvim_buf_get_lines(0, srow - 1, erow, false)
	if #lines == 0 then
		return ""
	end

	if #lines == 1 then
		lines[1] = string.sub(lines[1], scol, ecol)
	else
		lines[1] = string.sub(lines[1], scol)
		lines[#lines] = string.sub(lines[#lines], 1, ecol)
	end

	return table.concat(lines, "\n")
end

local function translate(text, callback)
	local body = vim.fn.json_encode({
		model = "hy-mt",
		prompt = "将以下文本翻译为中文，只输出翻译结果：\n\n" .. text,
		stream = false,
	})

	local chunks = {}
	vim.fn.jobstart({
		"curl", "-s", "-X", "POST",
		"http://localhost:11434/api/generate",
		"-H", "Content-Type: application/json",
		"-d", body,
	}, {
		stdout_buffered = true,
		on_stdout = function(_, data)
			if data then
				for _, line in ipairs(data) do
					if line ~= "" then
						table.insert(chunks, line)
					end
				end
			end
		end,
		on_exit = function(_, code)
			vim.schedule(function()
				if code ~= 0 then
					callback("Request failed")
					return
				end
				local ok, resp = pcall(vim.fn.json_decode, table.concat(chunks, "\n"))
				if ok and resp and resp.response then
					callback(nil, vim.trim(resp.response))
				else
					callback("Parse failed")
				end
			end)
		end,
	})
end

local function show_float(text, selection_start_row, selection_end_row)
	local lines = vim.split(text, "\n")

	local editor_width = vim.o.columns
	local editor_height = vim.o.lines - vim.o.cmdheight - 1
	local width = 120

	local wrapped_lines = 0
	for _, line in ipairs(lines) do
		local line_width = vim.fn.strdisplaywidth(line)
		wrapped_lines = wrapped_lines + math.max(1, math.ceil(line_width / width))
	end

	local height = math.min(wrapped_lines, math.floor(editor_height * 0.8))
	local col = math.floor((editor_width - width) / 2)

	-- Calculate selection position on screen
	local win_top = vim.fn.line("w0")
	local sel_start_screen = selection_start_row - win_top
	local sel_end_screen = selection_end_row - win_top

	-- Prefer below selection, fallback to above if not enough space
	local row
	local space_below = editor_height - sel_end_screen - 2
	local space_above = sel_start_screen - 1

	if space_below >= height then
		row = sel_end_screen + 2
	elseif space_above >= height then
		row = sel_start_screen - height - 1
	else
		-- Fallback to bottom of screen
		row = editor_height - height - 1
	end

	row = math.max(0, row)

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].modifiable = false

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		row = row,
		col = col,
		width = width,
		height = height,
		style = "minimal",
		border = "rounded",
		title = " Translation ",
		title_pos = "center",
	})

	local function close()
		vim.api.nvim_win_close(win, true)
	end
	vim.keymap.set("n", "q", close, { buffer = buf })
	vim.keymap.set("n", "<Esc>", close, { buffer = buf })
end

function M.setup()
	vim.api.nvim_create_user_command("Translate", function()
		local text = get_visual_selection()
		if text == "" then
			vim.notify("No text selected", vim.log.levels.WARN)
			return
		end

		local selection_start_row = vim.fn.getpos("'<")[2]
		local selection_end_row = vim.fn.getpos("'>")[2]

		vim.notify("Translating...", vim.log.levels.INFO)
		translate(text, function(err, result)
			if err then
				vim.notify("Translation failed: " .. err, vim.log.levels.ERROR)
			elseif result then
				vim.fn.setreg("+", result)
				show_float(result, selection_start_row, selection_end_row)
			end
		end)
	end, { range = true })
end

return M