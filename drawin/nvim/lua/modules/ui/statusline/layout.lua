local config = require("modules.ui.statusline.config")
local lsp = require "feline.providers.lsp"
local lsp_severity = vim.diagnostic.severity
local navic = require("nvim-navic")

local statusline_style = config.icon_styles["round"]
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

-- table.insert(components.active[1], {
--     provider = statusline_style.main_icon,

--     -- hl = {
--     --     fg = config.colors.statusline_bg,
--     --     bg = config.colors.nord_blue,
--     -- },
--     hl = function()
--         return {
--             fg = config.colors.statusline_bg,
--             bg = config.mode_colors[vim.fn.mode()][2],
--             style = "bold",
--         }
--     end,
-- })

table.insert(components.active[1], {
	-- provider = statusline_style.vi_mode_icon,
	provider = "",
	hl = function()
		return {
			fg = config.colors.statusline_bg,
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
	icon = "  ",
})

table.insert(components.active[1], {
	provider = "diagnostic_info",
	enabled = function()
		return lsp.diagnostics_exist(lsp_severity.INFO)
	end,
	hl = { fg = config.colors.green },
	icon = "  ",
})

table.insert(components.active[1], {
	provider = "git_branch",
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 70
	end,
	hl = {
		fg = config.colors.violet,
		bg = config.colors.lightbg,
	},
	icon = "  ",
	right_sep = {
		str = statusline_style.right,
		hl = {
			fg = config.colors.lightbg,
			bg = config.colors.statusline_bg,
		}
	},
})

-- table.insert(components.active[1], {
--     provider = function()
--         local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
--         return "  " .. dir_name .. " "
--     end,
--     enabled = shortline or function(winid)
--         return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 80
--     end,
--     hl = {
--         fg = config.colors.orange,
--         bg = config.colors.lightbg2,
--         style = "bold",
--     },
--     right_sep = {
--         str = statusline_style.right,
--         hl = {
--             fg = config.colors.lightbg2,
--             bg = config.colors.statusline_bg,
--         },
--     },
-- })

table.insert(components.active[1], {
	provider = function()
		local fname
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
		fg = config.colors.white,
		bg = config.colors.lightbg2,
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
		local _, color = require("nvim-web-devicons").get_icon_color(filename, extension)
		if color ~= nil then
			fg = color
		end
		return {
			fg = fg,
			bg = config.colors.lightbg2,
		}
	end,
	right_sep = {
		str = statusline_style.right,
		hl = {
			fg = config.colors.lightbg2,
			bg = config.colors.statusline_bg
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
		bg = config.colors.lightbg2,
	},
	right_sep = {
		str = statusline_style.right,
		hl = {
			fg = config.colors.lightbg2,
			bg = config.colors.statusline_bg
		}
	},
})

table.insert(components.active[2], {
	provider = config.get_diagnostic_info,
	hl = {
		fg = config.colors.orange,
		bg = config.colors.statusline_bg,
	}
})

table.insert(components.active[2], {
	provider = function()
		local Lsp = vim.lsp.util.get_progress_messages()[1]

		if Lsp then
			local msg = Lsp.message or ""
			local percentage = Lsp.percentage or 0
			local title = Lsp.title or ""
			local spinners = {
				"",
				"",
				"",
			}

			local success_icon = {
				"",
				"",
				"",
			}

			local ms = vim.loop.hrtime() / 1000000
			local frame = math.floor(ms / 120) % #spinners

			if percentage >= 70 then
				return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
			end

			return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
		end

		return ""
	end,
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 80
	end,
	hl = { fg = config.colors.orange },
})

table.insert(components.active[3], {
	provider = function()
		if next(vim.lsp.buf_get_clients()) ~= nil then
			return "  LSP "
		else
			return ""
		end
	end,
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 70
	end,
	hl = { fg = config.colors.grey_fg2, bg = config.colors.statusline_bg },
})

table.insert(components.active[3], {
	provider = "git_diff_added",
	hl = {
		fg = config.colors.grey_fg2,
		bg = config.colors.statusline_bg,
	},
	icon = " ",
})

-- diffModfified
table.insert(components.active[3], {
	provider = "git_diff_changed",
	hl = {
		fg = config.colors.grey_fg2,
		bg = config.colors.statusline_bg,
	},
	icon = "  ",
})
-- diffRemove
table.insert(components.active[3], {
	provider = "git_diff_removed",
	hl = {
		fg = config.colors.grey_fg2,
		bg = config.colors.statusline_bg,
	},
	icon = "  ",
})

table.insert(components.active[3], {
	provider = statusline_style.left,
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
	end,
	hl = {
		fg = config.colors.grey,
		bg = config.colors.one_bg,
	},
})

table.insert(components.active[3], {
	provider = statusline_style.left,
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
	end,
	hl = {
		fg = config.colors.green,
		bg = config.colors.grey,
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
		fg = config.colors.green,
		bg = config.colors.one_bg,
	},
})

table.insert(components.active[3], {
	provider = statusline_style.left,
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
	end,
	hl = {
		fg = config.colors.grey,
		bg = config.colors.one_bg,
	},
})

table.insert(components.active[3], {
	provider = config.get_system_info(),
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
	end,
	hl = {
		bg = config.colors.one_bg,
	}
})

require("feline").setup {
	theme = {
		bg = config.colors.statusline_bg,
		fg = config.colors.fg,
	},
	components = components,
}
