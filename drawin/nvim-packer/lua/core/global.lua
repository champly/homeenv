local global = {}
local home = os.getenv("HOME")
local path_seq = global.is_windows and "\\" or "/"
local os_name = vim.loop.os_uname().sysname

function global:load_variables()
	self.is_mac = os_name == "Darwin"
	self.is_linux = os_name == "Linux"
	self.is_windows = os_name == "Windows"
	self.vim_path = vim.fn.stdpath("config")
	self.cache_dir = home .. path_seq .. ".cache" .. path_seq .. "nvim" .. path_seq
	self.modules_dir = self.vim_path .. path_seq .. "modules"
	self.path_seq = path_seq
	self.home = home
	self.data_dir = string.format("%s/site/", vim.fn.stdpath("data"))
end

global:load_variables()

_G.completion_with_lsp = true

return global
