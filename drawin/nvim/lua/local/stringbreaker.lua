-- StringBreaker: escape/unescape strings in-place
-- Reference: https://github.com/duqcyxwd/stringbreaker.nvim

local M = {}

local unescape_map = {
	["\\\\"] = "\\",
	["\\n"] = "\n",
	["\\t"] = "\t",
	["\\r"] = "\r",
	['\\"'] = '"',
	["\\'"] = "'",
}

local escape_map = {
	["\\"] = "\\\\",
	["\n"] = "\\n",
	["\t"] = "\\t",
	["\r"] = "\\r",
}

-- Unescape: convert escape sequences to literal characters
local function unescape(str)
	-- Single pass: \\. matches \\ as a pair first, so \\n correctly becomes \n not newline
	return (str:gsub("\\.", function(seq)
		return unescape_map[seq] or seq
	end))
end

-- Escape: convert literal characters to escape sequences
local function escape(str, quote_char)
	quote_char = quote_char or '"'
	local map = vim.tbl_extend("force", escape_map, {
		[quote_char] = "\\" .. quote_char,
	})
	return (str:gsub(".", function(ch)
		return map[ch] or ch
	end))
end

-- Get selection range: visual selection or current line
local function get_selection(is_visual)
	local srow, scol, erow, ecol
	if is_visual then
		srow, scol = vim.fn.getpos("'<")[2], vim.fn.getpos("'<")[3]
		erow, ecol = vim.fn.getpos("'>")[2], vim.fn.getpos("'>")[3]
	else
		srow = vim.fn.line(".")
		scol, erow = 1, srow
		ecol = 2147483647
	end

	local lines = vim.api.nvim_buf_get_lines(0, srow - 1, erow, false)
	if #lines == 0 then
		return nil
	end

	-- Clamp ecol for visual-line mode or current-line mode
	if ecol >= 2147483647 then
		ecol = #lines[#lines]
	end

	return { lines = lines, srow = srow, scol = scol, erow = erow, ecol = ecol }
end

-- Perform transform on selection and replace in-place
local function do_transform(transform_fn, is_visual)
	local sel = get_selection(is_visual)
	if not sel then
		vim.notify("No text to transform", vim.log.levels.WARN)
		return
	end

	-- Extract selected text
	local lines = vim.deepcopy(sel.lines)
	local prefix = lines[1]:sub(1, sel.scol - 1)
	local suffix = lines[#lines]:sub(sel.ecol + 1)
	lines[1] = lines[1]:sub(sel.scol)
	lines[#lines] = lines[#lines]:sub(1, sel.ecol - (sel.srow == sel.erow and sel.scol - 1 or 0))

	-- For single-line, sub range is [scol, ecol]
	if #lines == 1 then
		lines[1] = sel.lines[1]:sub(sel.scol, sel.ecol)
	end

	local text = table.concat(lines, "\n")
	local result = transform_fn(text)

	-- Replace: prepend prefix / append suffix
	local new_lines = vim.split(result, "\n", { plain = true })
	new_lines[1] = prefix .. new_lines[1]
	new_lines[#new_lines] = new_lines[#new_lines] .. suffix

	vim.api.nvim_buf_set_lines(0, sel.srow - 1, sel.erow, false, new_lines)
end

function M.setup()
	vim.api.nvim_create_user_command("StringUnescape", function(opts)
		do_transform(unescape, opts.range > 0)
	end, { range = true })

	vim.api.nvim_create_user_command("StringEscape", function(opts)
		local quote_char = opts.args == "single" and "'" or '"'
		do_transform(function(text)
			return escape(text, quote_char)
		end, opts.range > 0)
	end, { range = true, nargs = "?" })
end

return M
