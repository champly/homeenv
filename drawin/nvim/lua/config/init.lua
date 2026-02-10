local cache_root = vim.fn.stdpath("state") .. "/"
local data_subs = { "backup", "session", "swap", "tags", "undo" }
for _, sub in ipairs(data_subs) do
	vim.fn.mkdir(cache_root .. sub, "p")
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
vim.g.loaded_ruby_provider     = 0
-- vim.g.did_load_filetypes       = 0
-- vim.g.do_filetype_lua          = 1

vim.g.mapleader                = ","
vim.keymap.set("n", " ", "", { noremap = true })
vim.keymap.set("x", " ", "", { noremap = true })

require("config.options")
require("config.autocmd")
require("config.lazy")
require("config.custom")
require("config.mapping")
require("config.lsp")
require("local.translate").setup()
require("local.stringbreaker").setup()
