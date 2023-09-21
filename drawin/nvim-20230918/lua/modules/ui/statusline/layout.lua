local config = require("modules.ui.statusline.config")
local lsp = require "feline.providers.lsp"
local lsp_severity = vim.diagnostic.severity
local navic = require("nvim-navic")

local statusline_style = config.icon_styles["round"]
local color = config.theme_color[vim.g.color_theme]
-- show short statusline on small screens
local shortline = false

-- Initialize the components table
local components = {
	active = {},
	inactive = {},
}

table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})

table.insert(components.active[1], {
	provider = "",
	hl = function()
		return {
			fg = color.statusline_bg,
			bg = config.mode_colors[vim.fn.mode()][2],
			style = "bold",
		}
	end,
})

table.insert(components.active[1], {
	provider = function()
		return " " .. config.mode_colors[vim.fn.mode()][1] .. " "
	end,
	hl = config.chad_mode_hl,
	right_sep = {
		str = statusline_style.right,
		hl = config.chad_mode_hl_sep,
	},
})

table.insert(components.active[1], {
	provider = "diagnostic_errors",
	enabled = function()
		return lsp.diagnostics_exist(lsp_severity.ERROR)
	end,
	hl = { fg = config.colors.red },
	icon = "  ",
})

table.insert(components.active[1], {
	provider = "diagnostic_warnings",
	enabled = function()
		return lsp.diagnostics_exist(lsp_severity.WARN)
	end,
	hl = { fg = config.colors.yellow },
	icon = "  ",
})

table.insert(components.active[1], {
	provider = "diagnostic_hints",
	enabled = function()
		return lsp.diagnostics_exist(lsp_severity.HINT)
	end,
	hl = { fg = config.colors.grey_fg2 },
	icon = "  ",
})

table.insert(components.active[1], {
	provider = "diagnostic_info",
	enabled = function()
		return lsp.diagnostics_exist(lsp_severity.INFO)
	end,
	hl = { fg = config.colors.green },
	icon = "  ",
})

table.insert(components.active[1], {
	provider = "git_branch",
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 70
	end,
	hl = {
		fg = config.colors.grey_fg2,
		bg = color.lightbg,
	},
	icon = "  ",
	right_sep = {
		str = statusline_style.right,
		hl = {
			fg = color.lightbg,
			bg = color.statusline_bg,
		}
	},
})

table.insert(components.active[1], {
	provider = function()
		local fname
		---@diagnostic disable-next-line: undefined-global
		if vim.api.nvim_win_get_width(tonumber(winid) or 0) > 30 then
			fname = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.")
		else
			fname = vim.fn.expand "%:t"
		end
		return " " .. fname .. " "
	end,
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 50 and #vim.fn.expand("%:t") > 0
	end,
	hl = {
		fg = config.colors.grey_fg2,
		bg = color.lightbg2,
	},
})

table.insert(components.active[1], {
	provider = function()
		local filename = vim.fn.expand "%:t"
		local extension = vim.fn.expand "%:e"
		local icon = require("nvim-web-devicons").get_icon(filename, extension)
		if icon == nil then
			return " "
		end
		return icon .. " "
	end,
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 70 and #vim.fn.expand("%:t") > 0
	end,
	hl = function()
		local filename = vim.fn.expand "%:t"
		local extension = vim.fn.expand "%:e"
		local fg = config.colors.white
		local _, col = require("nvim-web-devicons").get_icon_color(filename, extension)
		if col ~= nil then
			fg = col
		end
		return {
			fg = fg,
			bg = color.lightbg2,
		}
	end,
	right_sep = {
		str = statusline_style.right,
		hl = {
			fg = color.lightbg2,
			bg = color.statusline_bg
		}
	},
})

table.insert(components.active[1], {
	provider = function()
		return navic.get_location()
	end,
	enabled = function()
		return navic.is_available()
	end,
	hl = {
		fg = config.colors.white,
		bg = color.lightbg2,
	},
	right_sep = {
		str = statusline_style.right,
		hl = {
			fg = color.lightbg2,
			bg = color.statusline_bg
		}
	},
})

table.insert(components.active[2], {
	provider = config.get_diagnostic_info,
	hl = {
		fg = config.colors.orange,
		bg = color.statusline_bg,
	}
})

table.insert(components.active[2], {
	provider = function()
		local Lsp = vim.lsp.util.get_progress_messages()[1]

		if vim.o.columns < 120 or not Lsp then
			return ""
		end

		local msg = Lsp.message or ""
		local percentage = Lsp.percentage or 0
		local title = Lsp.title or ""
		local spinners = { "🌖", "🌗", "🌘", "🌑", "🌒", "🌓", "🌔" }
		-- local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
		local ms = vim.loop.hrtime() / 1000000
		local frame = math.floor(ms / 120) % #spinners
		return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
	end,
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 80
	end,
	hl = { fg = config.colors.orange },
})

table.insert(components.active[3], {
	provider = function()
		if next(vim.lsp.buf_get_clients()) ~= nil then
			local clients = {}
			for _, client in pairs(vim.lsp.buf_get_clients(0)) do
				clients[#clients + 1] = client.name
			end
			return "  " .. table.concat(clients, " ") .. " "
		else
			return ""
		end
	end,
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 70
	end,
	hl = { fg = config.colors.grey_fg2, bg = color.statusline_bg },
})

table.insert(components.active[3], {
	provider = "git_diff_added",
	hl = {
		fg = config.colors.grey_fg2,
		bg = color.statusline_bg,
	},
	icon = " ",
})

-- diffModfified
table.insert(components.active[3], {
	provider = "git_diff_changed",
	hl = {
		fg = config.colors.grey_fg2,
		bg = color.statusline_bg,
	},
	icon = "  ",
})
-- diffRemove
table.insert(components.active[3], {
	provider = "git_diff_removed",
	hl = {
		fg = config.colors.grey_fg2,
		bg = color.statusline_bg,
	},
	icon = "  ",
})

table.insert(components.active[3], {
	provider = statusline_style.left,
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
	end,
	hl = {
		fg = color.lightbg,
		bg = color.statusline_bg,
	},
})

table.insert(components.active[3], {
	provider = statusline_style.left,
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
	end,
	hl = {
		fg = config.colors.green,
		bg = color.statusline_bg,
	},
})

table.insert(components.active[3], {
	provider = statusline_style.position_icon,
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
	end,
	hl = {
		fg = config.colors.black,
		bg = config.colors.green,
	},
})

table.insert(components.active[3], {
	provider = function()
		local current_line = vim.fn.line "."
		local total_line = vim.fn.line "$"

		if current_line == 1 then
			return " Top "
		elseif current_line == vim.fn.line "$" then
			return " Bot "
		end
		local result, _ = math.modf((current_line / total_line) * 100)
		return " " .. result .. "%% "
	end,
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
	end,
	hl = {
		fg = color.normal_fg,
		bg = color.statusline_bg,
	},
})

table.insert(components.active[3], {
	provider = statusline_style.left,
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
	end,
	hl = {
		fg = color.lightbg,
		bg = color.statusline_bg,
	},
})

table.insert(components.active[3], {
	provider = config.get_system_info(),
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
	end,
	hl = {
		fg = color.icon_fg,
		bg = color.statusline_bg,
	}
})

require("feline").setup({
	theme = {
		bg = color.statusline_bg,
		fg = config.colors.fg,
	},
	components = components,
})
