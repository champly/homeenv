local telescope = require("telescope")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values

local golang_source = function()
	local root = os.getenv("HOME") .. "/go/src/"
	local result = {}

	local dicts = vim.fn.split(vim.fn.globpath(root, "*"))
	for _, dict in pairs(dicts) do
		if vim.fn.isdirectory(dict) then
			local organizes = vim.fn.split(vim.fn.globpath(dict, "*"))
			for _, organize in pairs(organizes) do
				local projects = vim.fn.split(vim.fn.globpath(organize, "*"))
				for _, project in pairs(projects) do
					table.insert(result, project)
				end
				table.insert(result, organize)
			end
		end
	end

	return result
end

local gosource = function(opts)
	opts = opts or {}
	local results = golang_source()

	pickers.new(opts, {
		prompt_title = "Find In Go Root",
		results_title = "Go Source Code",
		finder = finders.new_table {
			results = results,
			entry_maker = make_entry.gen_from_file(opts)
		},
		previewer = conf.file_previewer(opts),
		sorter = conf.file_sorter(opts)
	}):find()
end

return telescope.register_extension {
	exports = {
		gosource = gosource,
	}
}
