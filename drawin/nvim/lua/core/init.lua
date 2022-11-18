local global = require "core.global"
local vim = vim

-- Create cache dir and subs dir
local data_dir = {
	global.cache_dir .. "backup",
	global.cache_dir .. "session",
	global.cache_dir .. "swap",
	global.cache_dir .. "tags",
	global.cache_dir .. "undo",
}
-- There only check once that If cache_dir exists
-- Then I don't want to check subs dir exists
if vim.fn.isdirectory(global.cache_dir) == 0 then
	os.execute("mkdir -p " .. global.cache_dir)
	for _, v in pairs(data_dir) do
		if vim.fn.isdirectory(v) == 0 then
			os.execute("mkdir -p " .. v)
		end
	end
end

-- disable_distribution_plugins
vim.g.loaded_gzip              = 1
vim.g.loaded_tar               = 1
vim.g.loaded_tarPlugin         = 1
vim.g.loaded_zip               = 1
vim.g.loaded_zipPlugin         = 1
vim.g.loaded_getscript         = 1
vim.g.loaded_getscriptPlugin   = 1
vim.g.loaded_vimball           = 1
vim.g.loaded_vimballPlugin     = 1
vim.g.loaded_matchit           = 1
vim.g.loaded_matchparen        = 1
vim.g.loaded_2html_plugin      = 1
vim.g.loaded_logiPat           = 1
vim.g.loaded_rrhelper          = 1
vim.g.loaded_netrw             = 1
vim.g.loaded_netrwPlugin       = 1
vim.g.loaded_netrwSettings     = 1
vim.g.loaded_netrwFileHandlers = 1
-- vim.g.did_load_filetypes       = 0
-- vim.g.do_filetype_lua          = 1

vim.g.mapleader = ","
vim.api.nvim_set_keymap("n", " ", "", { noremap = true })
vim.api.nvim_set_keymap("x", " ", "", { noremap = true })

-- for neovide
-- https://github.com/neovide/neovide#some-nonsense-
vim.o.guifont = "SauceCodePro Nerd Font"
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_fullscreen = "v:true"

require("core.options")
require("core.mapping")
require("core.event")

-- TODO rewrite with lua
local cmd = "source " .. vim.fn.stdpath("config") .. "/lua/core/other.vim"
vim.api.nvim_exec(cmd, false)

-- new packer autoload
vim.cmd [[ silent! command PackerClean lua require("modules.pack") require("packer").clean() ]]
vim.cmd [[ silent! command PackerCompile lua require("modules.pack") require("packer").compile() ]]
vim.cmd [[ silent! command PackerInstall lua require("modules.pack") require("packer").install() ]]
vim.cmd [[ silent! command PackerStatus lua require("modules.pack") require("packer").status() ]]
vim.cmd [[ silent! command PackerSync lua require("modules.pack") require("packer").sync() ]]
vim.cmd [[ silent! command PackerUpdate lua require("modules.pack") require("packer").update() ]]
if not vim.loop.fs_stat(vim.fn.stdpath("config") .. "/plugin/packer_compiled.lua") then
	vim.cmd [[ autocmd VimEnter * PackerSync ]]
end
