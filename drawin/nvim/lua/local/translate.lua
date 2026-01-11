-- Translate using Ollama with HY-MT model
-- https://huggingface.co/tencent/HY-MT1.5-1.8B-GGUF
--
-- Setup Ollama model:
-- echo 'FROM hf.co/tencent/HY-MT1.5-1.8B-GGUF:Q8_0
-- TEMPLATE """<｜hy_begin▁of▁sentence｜>{{ if .System }}{{ .System }}<｜hy_place▁holder▁no▁3｜>{{ end }}{{ if .Prompt }}<｜hy_User｜>{{ .Prompt }}{{ end }}<｜hy_Assistant｜>"""' > /tmp/Modelfile
-- ollama create hy-mt -f /tmp/Modelfile

local M = {}

local function get_visual_selection()
	local _, srow, scol = unpack(vim.fn.getpos("'<"))
	local _, erow, ecol = unpack(vim.fn.getpos("'>"))

	if srow > erow or (srow == erow and scol > ecol) then
		srow, erow = erow, srow
		scol, ecol = ecol, scol
	end

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

local function show_float(text)
	local lines = vim.split(text, "\n")

	local max_width = 0
	for _, line in ipairs(lines) do
		max_width = math.max(max_width, vim.fn.strdisplaywidth(line))
	end

	local width = math.min(math.max(max_width + 2, 40), math.floor(vim.o.columns * 0.9))
	local height = math.min(#lines, math.floor(vim.o.lines * 0.8))

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].modifiable = false

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "cursor",
		row = 1,
		col = 0,
		width = width,
		height = height,
		style = "minimal",
		border = "rounded",
		title = " Translation ",
		title_pos = "center",
	})

	vim.keymap.set("n", "q", function()
		vim.api.nvim_win_close(win, true)
	end, { buffer = buf })
	vim.keymap.set("n", "<Esc>", function()
		vim.api.nvim_win_close(win, true)
	end, { buffer = buf })
end

function M.setup()
	vim.api.nvim_create_user_command("Translate", function()
		local text = get_visual_selection()
		if text == "" then
			vim.notify("No text selected", vim.log.levels.WARN)
			return
		end

		vim.notify("Translating...", vim.log.levels.INFO)
		translate(text, function(err, result)
			if err then
				vim.notify("Translation failed: " .. err, vim.log.levels.ERROR)
			elseif result then
				vim.fn.setreg("+", result)
				show_float(result)
			end
		end)
	end, { range = true })
end

return M