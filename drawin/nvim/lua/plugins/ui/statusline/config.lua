local M = {}

M.icon_styles = {
	default = {
		left = "",
		right = " ",
		main_icon = "  ",
		vi_mode_icon = " ",
		position_icon = " ",
	},
	arrow = {
		left = "",
		right = "",
		main_icon = "  ",
		vi_mode_icon = " ",
		position_icon = " ",
	},
	block = {
		left = " ",
		right = " ",
		main_icon = "   ",
		vi_mode_icon = "  ",
		position_icon = "  ",
	},
	round = {
		left = "",
		right = "",
		main_icon = "  ",
		vi_mode_icon = " ",
		position_icon = " ",
	},
	slant = {
		left = " ",
		right = " ",
		main_icon = "  ",
		vi_mode_icon = " ",
		position_icon = " ",
	},
}

M.system_icons = {
	Linux = ' ',
	Darwin = ' ',
	Windows = ' ',
}

M.theme_color = {
	dark = {
		statusline_bg = "#2c2c2c",
		lightbg = "#353535",
		lightbg2 = "#303030",
		mode_fg = "#2c2c2c",
		normal_fg = "#b8bb26",
		icon_fg = "",
	},
	light = {
		statusline_bg = "#c7c7c7",
		lightbg = "#c7c7c7",
		lightbg2 = "#c7c7c7",
		mode_fg = "#ffffff",
		normal_fg = "#669900",
		icon_fg = "#000000",
	}
}

M.colors = {
	white = "#ebdbb2",
	darker_black = "#232323",
	black = "#282828", --  nvim bg
	black2 = "#2e2e2e",
	one_bg = "#353535",
	one_bg2 = "#3f3f3f",
	one_bg3 = "#444444",
	grey = "#464646",
	grey_fg = "#4e4e4e",
	grey_fg2 = "#505050",
	light_grey = "#565656",
	red = "#fb4934",
	baby_pink = "#cc241d",
	pink = "#ff75a0",
	line = "#2c2f30", -- for lines like vertsplit
	green = "#b8bb26",
	vibrant_green = "#a9b665",
	nord_blue = "#83a598",
	blue = "#51afef",
	yellow = "#d79921",
	sun = "#fabd2f",
	purple = "#b4bbc8",
	dark_purple = "#d3869b",
	teal = "#749689",
	orange = "#ff8800",
	cyan = "#82b3a8",
}

M.mode_colors = {
	["n"] = { "NORMAL", M.colors.green },
	["no"] = { "N-PENDING", M.colors.red },
	["i"] = { "INSERT", M.colors.blue },
	["ic"] = { "INSERT", M.colors.blue },
	["t"] = { "TERMINAL", M.colors.orange },
	["v"] = { "VISUAL", M.colors.cyan },
	["V"] = { "V-LINE", M.colors.cyan },
	[""] = { "V-BLOCK", M.colors.cyan },
	[""] = { "S-BLOCK", M.colors.nord_blue },
	["R"] = { "REPLACE", M.colors.orange },
	["Rv"] = { "V-REPLACE", M.colors.orange },
	["s"] = { "SELECT", M.colors.nord_blue },
	["S"] = { "S-LINE", M.colors.nord_blue },
	["c"] = { "COMMAND", M.colors.orange },
	["cv"] = { "COMMAND", M.colors.orange },
	["ce"] = { "COMMAND", M.colors.orange },
	["r"] = { "PROMPT", M.colors.teal },
	["rm"] = { "MORE", M.colors.teal },
	["r?"] = { "CONFIRM", M.colors.teal },
	["!"] = { "SHELL", M.colors.green },
}

M.chad_mode_hl = function()
	return {
		fg = M.theme_color[vim.g.color_theme].mode_fg,
		bg = M.mode_colors[vim.fn.mode()][2],
		style = "bold",
	}
end

M.chad_mode_hl_sep = function()
	return {
		fg = M.mode_colors[vim.fn.mode()][2],
		bg = M.theme_color[vim.g.color_theme].statusline_bg,
	}
end

M.get_system_info = function()
	-- Darwin/Linux/Windows
	---@diagnostic disable-next-line: undefined-field
	return M.system_icons[vim.uv.os_uname().sysname]
end

M.lsp_status = function(status)
	local shorter_stat = ""
	for match in string.gmatch(status, "[^%s]+") do
		local err_warn = string.find(match, "^[WE]%d+", 0)
		if not err_warn then
			shorter_stat = shorter_stat .. " " .. match
		end
	end
	return shorter_stat
end

M.get_coc_lsp = function()
	local status = vim.fn['coc#status']()
	if not status or status == '' then
		return ''
	end
	return M.lsp_status(status)
end

M.get_diagnostic_info = function()
	if vim.fn.exists('*coc#rpc#start_server') == 1 then
		return M.get_coc_lsp()
	end
	return ''
end

return M
