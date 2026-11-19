-- popup.lua: two-state popup factory.
-- Cmd-bound toggle: opens the tool in a floating layer if not running,
-- closes it if already open. No keep-alive: quitting the tool (q)
-- closes the layer too.

local M = {}
local SHELL = "com.superlogical.terminal.shell"
local TERMINAL = "com.superlogical.terminal"

function M.toggle(name, command, bounds)
	bounds = bounds or { 0.05, 0.05, 0.9, 0.9 }
	rex.action {
		name = name,
		title = name .. " (Toggle)",
		run = function (ctx)
			local list, err = rex.session.list_blocks {}
			if err ~= nil or list == nil then error(err or "list failed", 0) end

			-- Already open: close it
			for _, b in ipairs(list.blocks) do
				if b.label == name then
					rex.call("block.close", { session_id = ctx.session_id, block_id = b.block_id })
					return
				end
			end

			-- Not open: start it in the focused pane's working directory
			local r = rex.block.call(TERMINAL, "pwd", { block_id = ctx.block_id })
			local cwd = r and r.pwd and (r.pwd:gsub("^file://[^/]*", ""))
			local made, e = rex.session.new_layer {
				bounds = bounds,
				focus = true,
				layout = rex.layout.block { flavor = SHELL, options = { command = command, cwd = cwd } }
			}
			if e then error(e, 0) end
			rex.session.set_block_label { block_id = made.block_ids[1], label = name }
		end
	}
end

return M
