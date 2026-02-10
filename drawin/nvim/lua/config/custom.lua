-- gomodifytags -file ~/Dropbox/go/src/demo/debug/interface.go -line 14,15 -add-tags json
function AddTagsToSelection(start_line, end_line)
	-- get filename
	local filename = vim.api.nvim_buf_get_name(0)

	-- exec gomodifytags
	local command = string.format("gomodifytags -file %s -line %d,%d -add-tags json  -add-options json=omitempty",
		filename,
		start_line,
		end_line
	)
	local output_file = io.popen(command)
	if output_file == nil then
		return
	end
	local modified_text = output_file:read("*all")
	output_file:close()

	-- set modified text to buffer
	local modified_lines = vim.split(modified_text, "\n")
	local total_lines = vim.api.nvim_buf_line_count(0)
	vim.api.nvim_buf_set_lines(0, 0, total_lines, false, modified_lines)

	-- save
	vim.cmd("write")
end

function RemoveTagsFromSelection(start_line, end_line)
	-- get filename
	local filename = vim.api.nvim_buf_get_name(0)

	-- exec gomodifytags
	local command = string.format("gomodifytags -file %s -line %d,%d -remove-tags json",
		filename,
		start_line,
		end_line
	)
	local output_file = io.popen(command)
	if output_file == nil then
		return
	end
	local modified_text = output_file:read("*all")
	output_file:close()

	-- set modified text to buffer
	local modified_lines = vim.split(modified_text, "\n")
	local total_lines = vim.api.nvim_buf_line_count(0)
	vim.api.nvim_buf_set_lines(0, 0, total_lines, false, modified_lines)

	-- save
	vim.cmd("write")
end

vim.cmd("command! -range AddTags lua AddTagsToSelection(<line1>, <line2>)")
vim.cmd("command! -range RemoveTags lua RemoveTagsFromSelection(<line1>, <line2>)")

-- toggle quickfix
function ToggleQF()
	local qf_open = false
	for _, win in pairs(vim.fn.getwininfo()) do
		if win["quickfix"] == 1 then
			qf_open = true
		end
	end
	if qf_open == true then
		vim.cmd("cclose")
		return
	end
	if not vim.tbl_isempty(vim.fn.getqflist()) then
		vim.cmd("copen")
	end
end

-- toggle quickfix mapping
vim.keymap.set("n", "<leader>q", ToggleQF, { noremap = true, silent = true, desc = "Toggle quickfix" })

-- nvimdap config
function CopyDapConfig()
	-- get all template
	local template_dir = vim.fn.stdpath("config") .. "/external/nvimdap/"
	local config_list = vim.fn.split(vim.fn.glob(template_dir .. "*"), '\n')
	local files = {}
	for _, file in ipairs(config_list) do
		table.insert(files, { file = file, text = file })
	end

	local snacks_picker = require("snacks.picker")
	snacks_picker.pick({
		title = "Choice one nvim-dap configuration",
		items = files,
		actions = {
			confirm = function(picker, item)
				local launchPath = vim.fn.getcwd() .. "/.vscode/launch.json"
				-- mkdir
				local folder_path = launchPath:match("(.*/)")
				vim.fn.mkdir(folder_path, "p")

				-- copy file
				---@diagnostic disable-next-line: undefined-field
				vim.uv.fs_copyfile(item.text, launchPath, { excl = true }, function(err)
					if err then
						vim.notify("Create failed: " .. err, vim.log.levels.ERROR)
					else
						vim.notify("Create success " .. item.text .. " to current project!", vim.log.levels.INFO)
					end
				end)

				-- close picker
				picker:close()

				-- edit launchPath
				vim.cmd.edit(launchPath)
			end
		}
	})
end

vim.api.nvim_set_hl(0, "NormalFloat", { bg = "None" })
vim.keymap.set("n", "<leader>dt", CopyDapConfig, { noremap = true, silent = true, desc = "Copy DAP template" })

-- format selected JSON content using biome via stdin
-- works in any buffer (including temp/unsaved buffers)
-- usage: visual select JSON text, then :'<,'>FormatJson
local biome_config_path = vim.fn.stdpath("config") .. "/external/format"

vim.api.nvim_create_user_command("FormatJson", function(opts)
	local biome = vim.fn.exepath("biome")
	if biome == "" then
		vim.notify("biome not found in PATH", vim.log.levels.ERROR)
		return
	end

	local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
	local result = vim.system({
		biome, "format",
		"--stdin-file-path", "dummy.json",
		"--config-path", biome_config_path,
	}, { stdin = table.concat(lines, "\n"), text = true }):wait()

	if result.code ~= 0 then
		vim.notify("biome format error: " .. (result.stderr or "unknown"), vim.log.levels.ERROR)
		return
	end

	local formatted = (result.stdout or ""):gsub("\n$", "")
	vim.api.nvim_buf_set_lines(0, opts.line1 - 1, opts.line2, false, vim.split(formatted, "\n"))
end, { range = true, desc = "Format selected JSON with biome" })
