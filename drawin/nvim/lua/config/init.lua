local cache_root = vim.fn.stdpath("state") .. "/"
local data_subs = { "undo" }
for _, sub in ipairs(data_subs) do
	vim.fn.mkdir(cache_root .. sub, "p")
end

-- disable_distribution_plugins
vim.g.loaded_matchparen        = 1
vim.g.loaded_netrw             = 1
vim.g.loaded_netrwPlugin       = 1
vim.g.loaded_netrwSettings     = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_ruby_provider     = 0

vim.g.mapleader                = ","

require("config.options")
require("config.autocmd")
require("config.lazy")
require("config.custom")
require("config.mapping")
require("config.lsp")
require("local.translate").setup()
require("local.stringbreaker").setup()
