local helper = require("core.helper")
local vim_path = helper.get_config_path()
local modules_dir = vim_path .. "/lua/modules"

local present, packer = pcall(require, "modules.packer_init")
if not present then
	return false
end

local use = packer.use

local load_plugins = function()
	local get_plugins_list = function()
		local list = {}
		local tmp = vim.split(vim.fn.globpath(modules_dir, "*/plugins.lua"), "\n")

		for _, f in ipairs(tmp) do
			list[#list + 1] = string.match(f, 'lua/(.+).lua$')
			-- list[#list + 1] = f:sub(#modules_dir - #modules_str + 1, -1) -- add 'modules/' prefix
		end
		return list
	end

	local repolist = {}
	for _, m in ipairs(get_plugins_list()) do
		local repos = require(m:sub(0, #m - 4)) -- remove .lua suffix
		for repo, conf in pairs(repos) do
			repolist[#repolist + 1] = vim.tbl_extend("force", { repo }, conf)
		end
	end
	return repolist
end

return packer.startup(function()
	use { "wbthomason/packer.nvim", opt = true }

	for _, repo in ipairs(load_plugins()) do
		use(repo)
	end
end)
