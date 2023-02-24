local telescope = require("telescope")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local vimspector_list = function()
	local list = {}

	local path = vim.fn.stdpath("config") .. "/vimspector"
	local config_list = io.popen("rg --files " .. path)
	---@diagnostic disable-next-line: need-check-nil
	for file in config_list:lines() do
		table.insert(list, file)
	end

	return list
end

local vimspector_configuration_list = function(opts)
	opts = opts or {}
	local results = vimspector_list()

	pickers.new(opts, {
		prompt_title = "Choice one vimspector configuration",
		results_title = "Configuration content",
		finder = finders.new_table({
			results = results,
			entry_maker = make_entry.gen_from_file(opts)
		}),
		---@diagnostic disable-next-line: unused-local
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				local config_file = selection[1]
				vim.cmd(string.format(":tabedit .vimspector.json"))
				vim.cmd(string.format(":0r %s", config_file))
			end)
			return true
		end,
		previewer = conf.file_previewer(opts),
		sorter = conf.file_sorter(opts)
	}):find()
end

return telescope.register_extension {
	exports = {
		vimspector = vimspector_configuration_list,
	}
}
