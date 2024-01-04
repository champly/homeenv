local LazyUtil = require("lazy.core.util")

local M = {}

local deprecated = {
	get_clients = "lsp",
	on_attach = "lsp",
	on_rename = "lsp",
	root_Patterns = { "root", "patterns" },
}

---@param plugin string
function M.has(plugin)
	return require("lazy.core.config").spec.plugins[plugin] ~= nil
end

return M
