-- vim.cmd "packadd packer.nvim"
-- autoload will work's well
pcall(vim.cmd, "packadd! packer.nvim")

local present, packer = pcall(require, "packer")

if not present then
	local packer_path = vim.fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"

	print "Cloning packer.."
	-- remove the dir before cloning
	vim.fn.delete(packer_path, "rf")
	vim.fn.system {
		"git",
		"clone",
		"https://github.com/wbthomason/packer.nvim",
		"--depth",
		"1",
		packer_path,
	}

	vim.cmd "packadd packer.nvim"
	present, packer = pcall(require, "packer")

	if present then
		print "Packer cloned successfully."
	else
		error("Couldn't clone packer !\nPacker path: " .. packer_path .. "\n" .. packer)
	end
end

-- https://github.com/wbthomason/packer.nvim#custom-initialization
packer.init {
	display = {
		-- https://github.com/wbthomason/packer.nvim#using-a-floating-window
		open_fn = function()
			return require("packer.util").float { border = "single" }
		end,
		prompt_border = "single",
	},
	git = {
		clone_timeout = 120, -- seconds
	},
	auto_clean = true,
	compile_on_sync = true,
}

return packer
