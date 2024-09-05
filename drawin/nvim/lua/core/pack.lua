local pack = {}
pack.__index = pack

local modules_dir = vim.fn.stdpath("config") .. "/lua/modules"

function pack:load_modules_packages()
	self.repos = {}

	local list = vim.fs.find("package.lua", { path = modules_dir, type = "file", limit = 10 })
	if #list == 0 then
		return
	end

	local disable_modules = {}
	if vim.fn.exists("g:disable_modules") == 1 then
		disable_modules = vim.split(vim.g.disable_modules, ",", { trimempty = true })
	end

	for _, f in pairs(list) do
		local _, pos = f:find(modules_dir)
		f = f:sub(pos - #"modules" + 1, #f - #".lua")
		if not vim.tbl_contains(disable_modules, f) then
			require(f)
		end
	end
end

function pack:boot_strap()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.uv.fs_stat(lazypath) then
		local out = vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"--branch=stable",
			"https://github.com/folke/lazy.nvim.git",
			lazypath,
		})
		if vim.v.shell_error ~= 0 then
			vim.api.nvim_echo({
				{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
				{ out,                            "WarningMsg" },
				{ "\nPress any key to exit..." },
			}, true, {})
			vim.fn.getchar()
			os.exit(1)
		end
	end
	vim.opt.rtp:prepend(lazypath)
	self:load_modules_packages()

	require("lazy").setup(self.repos, {
		-- concurrency = 10,
		checker = {
			enable = true,
			notify = true, -- get a notification when new updates are found
			frequency = 3600, -- check for updates every hour
		},
	})
end

function pack.package(repo)
	if not pack.repos then
		pack.repos = {}
	end
	table.insert(pack.repos, repo)
end

return pack
