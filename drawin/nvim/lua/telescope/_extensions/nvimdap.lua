local telescope = require("telescope")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local nvim_dap_list = function()
	local list = {}

	local path = vim.fn.stdpath("config") .. "/external/nvimdap"
	local config_list = io.popen("rg --files " .. path)
	---@diagnostic disable-next-line: need-check-nil
	for file in config_list:lines() do
		table.insert(list, file)
	end

	return list
end

local read_file = function(path)
	local file = io.open(path, "r")
	if file then
		local content = file:read("*all")
		file:close()
		return content
	else
		print("can't read file：" .. path)
		return nil
	end
end

local create_launch_file = function(path, content)
	local folder_path = path:match("(.*/)")
	vim.fn.mkdir(folder_path, "p")

	local file = io.open(path, "w")
	if file then
		file:write(content)
		file:close()
	else
		print("create " .. path .. " failed")
	end
end

local nvim_dap_configuration_list = function(opts)
	opts = opts or {}
	local results = nvim_dap_list()

	pickers.new(opts, {
		prompt_title = "Choice one nvim-dap configuration",
		results_title = "Configuration content",
		finder = finders.new_table({
			results = results,
			entry_maker = make_entry.gen_from_file(opts)
		}),

		attach_mappings = function(prompt_bufnr, _)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()

				local launchPath = vim.fn.getcwd() .. "/.vscode/launch.json"
				local content = read_file(selection[1])
				create_launch_file(launchPath, content)

				vim.api.nvim_command("edit " .. launchPath)
			end)
			return true
		end,
		previewer = conf.file_previewer(opts),
		sorter = conf.file_sorter(opts)
	}):find()
end

return telescope.register_extension {
	exports = {
		nvimdap = nvim_dap_configuration_list,
	}
}
