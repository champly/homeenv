-- OSC escape sequence utilities with tmux DCS passthrough support.
-- Neovim TUI owns stdout, so in tmux we write to stderr via /dev/fd/2.
-- See: https://github.com/tmux/tmux/issues/4833

local M = {}

--- Write raw bytes to the host terminal via stderr.
---@param seq string
local function tty_write(seq)
	if vim.fn.filewritable("/dev/fd/2") == 1 then
		vim.fn.writefile({ seq }, "/dev/fd/2", "b")
	else
		vim.fn.chansend(vim.v.stderr, seq)
	end
end

--- Send an OSC sequence to the terminal.
--- In tmux, wraps with DCS passthrough so it reaches the outer terminal.
---@param osc string raw OSC sequence, e.g. "\027]9;4;3\027\\"
function M.send(osc)
	if vim.env.TMUX then
		-- Replace ESC-based ST with BEL to avoid DCS terminator conflict
		local inner = osc:gsub("\027\\", "\007")
		local dcs = string.format("\027Ptmux;\027%s\027\\", inner)
		tty_write(dcs)
	else
		vim.api.nvim_ui_send(osc)
	end
end

--- Send OSC 9;4 progress indicator.
--- State values (ConEmu OSC 9;4 spec):
---   0       = remove/clear progress bar
---   1;N     = set determinate progress to N%
---   2;N     = error (red) progress at N%
---   3       = indeterminate (blue bar sliding animation)
---   4;N     = warning (yellow) progress at N%
---@param state integer 0=clear, 1=determinate, 2=error, 3=indeterminate, 4=warning
---@param percent? integer 0-100, used when state is 1, 2, or 4
function M.progress(state, percent)
	if percent and (state == 1 or state == 2 or state == 4) then
		M.send(string.format("\027]9;4;%d;%d\027\\", state, percent))
	else
		M.send(string.format("\027]9;4;%d\027\\", state))
	end
end

return M