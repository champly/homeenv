local gl = require("galaxyline")
local condition = require("galaxyline.condition")
local utils = require("modules.ui.utils")
local gls = gl.section
gl.short_line_list = { "NvimTree", "vista", "dbui", "packer", "coc-explorer", "vim-plug", "tagbar" }
local u = utils.u

local colors = {
	-- bg = '#202328',
	bg = '#3e3e3e',
	fg = '#bbc2cf',
	yellow = '#ECBE7B',
	cyan = '#008080',
	darkblue = '#081633',
	green = '#98be65',
	orange = '#FF8800',
	violet = '#a9a1e1',
	magenta = '#c678dd',
	blue = '#51afef',
	red = '#ec5f67',
}

local sep = {
	right_filled = u 'e0b2',
	left_filled = u 'e0b0',
	right = u 'e0b3',
	left = u 'e0b1',
	-- right_filled = u '2590',
	-- left_filled = u '258c',
	-- right = u '2503',
	-- left = u '2503',
}

local icons = {
	locker = u 'f023',
	unsaved = u 'f693',
	dos = u 'e70f',
	unix = u 'f17c',
	mac = u 'f179',
	lsp_warn = u 'f071',
	lsp_error = u 'f46e'
}

local system_icons = {
	Darwin = u 'f302',
	Linux = u 'f17c',
	Windows = u 'f17a',
}

local function buffer_not_empty()
	if vim.fn.empty(vim.fn.expand '%:t') ~= 1 then
		return true
	end
	return false
end

local function wide_enough()
	local squeeze_width = vim.fn.winwidth(0)
	if squeeze_width > 80 then
		return true
	end
	return false
end

local function highlight(group, fg, bg, gui)
	local cmd = string.format('highlight %s guifg=%s guibg=%s', group, fg, bg)
	if gui ~= nil then
		cmd = cmd .. ' gui=' .. gui
	end
	vim.cmd(cmd)
end

local function lsp_status(status)
	local shorter_stat = ''
	for match in string.gmatch(status, "[^%s]+") do
		local err_warn = string.find(match, "^[WE]%d+", 0)
		if not err_warn then
			shorter_stat = shorter_stat .. ' ' .. match
		end
	end
	return shorter_stat
end

local function get_coc_lsp()
	local status = vim.fn['coc#status']()
	if not status or status == '' then
		return ''
	end
	return lsp_status(status)
end

local function get_diagnostic_info()
	if vim.fn.exists('*coc#rpc#start_server') == 1 then
		return get_coc_lsp()
	end
	return ''
end

local function get_system_info()

	-- Darwin/Linux/Windows
	return system_icons[vim.loop.os_uname().sysname]
end

gls.left[2] = {
	ViMode = {
		provider = function()
			-- auto change color according the vim mode
			local alias = {
				n = 'NORMAL',
				i = 'INSERT',
				c = 'COMMAND',
				V = 'VISUAL',
				[''] = 'VISUAL-BLOCK',
				[''] = 'S-BLOCK',
				v = 'VISUAL',
				R = 'REPLACE',
				s = 'SUBSTITUTE',
				t = 'TERMINAL',
			}
			local mode_color = {
				n = colors.green,
				i = colors.blue,
				c = colors.orange,
				V = colors.magenta,
				[''] = colors.magenta,
				[''] = colors.magenta,
				v = colors.magenta,
				R = colors.red,
				s = colors.orange,
				t = colors.orange,
			}
			local vim_mode = vim.fn.mode()
			if mode_color[vim_mode] == nil then
				return 'N/A'
			end
			vim.api.nvim_command('hi GalaxyViMode guibg=' .. mode_color[vim_mode])
			highlight("GalaxyViModeInv", mode_color[vim_mode], colors.bg, nil)
			return '  ' .. alias[vim_mode] .. ' '
		end,
		highlight = { colors.bg, colors.line_bg, 'bold' },
		separator = sep.left_filled,
		separator_highlight = "GalaxyViModeInv"
	}
}

gls.left[3] = {
	DiagnosticError = {
		provider = function()
			local num = require('galaxyline.provider_diagnostic').get_diagnostic_error()
			if num == nil or num == "" then
				return "0 "
			else
				return num .. " "
			end
		end,
		icon = '   ',
		highlight = { colors.red, colors.bg }
	}
}

gls.left[4] = {
	DiagnosticWarn = {
		provider = function()
			local num = require('galaxyline.provider_diagnostic').get_diagnostic_warn()
			if num == nil or num == "" then
				return "0 "
			else
				return num .. " "
			end
		end,
		icon = '  ',
		highlight = { colors.yellow, colors.bg },
	}
}

gls.left[5] = {
	DiagnosticHint = {
		provider = function()
			local num = require('galaxyline.provider_diagnostic').get_diagnostic_hint()
			if num == nil or num == "" then
				return "0 "
			else
				return num .. " "
			end
		end,
		icon = '  ',
		highlight = { colors.blue, colors.bg },
		separator = sep.left,
		separator_highlight = { colors.fg, colors.bg },
	}
}

gls.left[6] = {
	GitIcon = {
		provider = function()
			return '  '
		end,
		condition = condition.check_git_workspace,
		separator_highlight = { 'NONE', colors.bg },
		highlight = { colors.violet, colors.bg, 'bold' }
	}
}

gls.left[7] = {
	GitBranch = {
		provider = 'GitBranch',
		condition = condition.check_git_workspace,
		highlight = { colors.violet, colors.bg, 'bold' },
		separator = sep.left,
		separator_highlight = { colors.fg, colors.bg },
	}
}

gls.left[8] = {
	FileName = {
		provider = function()
			if not buffer_not_empty() then
				return ''
			end
			local fname
			if wide_enough() then
				fname = vim.fn.fnamemodify(vim.fn.expand '%', ':~:.')
			else
				fname = vim.fn.expand '%:t'
			end
			if #fname == 0 then
				return ''
			end
			if vim.bo.readonly then
				fname = '  ' .. fname .. ' ' .. icons.locker
			end
			if vim.bo.modified then
				fname = '  ' .. fname .. ' ' .. icons.unsaved
			end
			return '  ' .. fname .. ' '
		end,
		condition = condition.buffer_not_empty,
		highlight = { colors.fg, colors.bg, 'bold' },
	}
}

gls.left[9] = {
	FileIcon = {
		provider = function()
			local fname, ext = vim.fn.expand '%:t', vim.fn.expand '%:e'
			local icon = require("nvim-web-devicons").get_icon(fname, ext)
			if icon == nil then
				return ' '
			end
			return ' ' .. icon .. ' '
		end,
		condition = condition.buffer_not_empty,
		highlight = { require('galaxyline.provider_fileinfo').get_file_icon_color, colors.bg },
		separator = sep.left,
		separator_highlight = { colors.fg, colors.bg },
	}
}

-- gls.mid[1] = {
--     ShowLspClient = {
--         provider = 'GetLspClient',
--         condition = function ()
--             local tbl = {['dashboard'] = true, ['']=true}
--             if tbl[vim.bo.filetype] then
--                 return false
--             end
--             return true
--         end,
--         icon = ' LSP:',
--         highlight = {colors.yellow, colors.bg, 'bold'}
--     }
-- }

gls.left[10] = {
	CocStatus = {
		provider = get_diagnostic_info,
		highlight = { colors.orange, colors.bg },
	}
}


gls.right[1] = {
	LineInfo = {
		provider = 'LineColumn',
		separator = string.format("%s ", sep.right),
		separator_highlight = { 'NONE', colors.bg },
		highlight = { colors.fg, colors.bg }
	}
}

gls.right[2] = {
	PerCent = {
		provider = 'LinePercent',
		-- separator = ' ',
		separator_highlight = { 'NONE', colors.bg },
		highlight = { colors.fg, colors.bg, 'bold' }
	}
}

gls.right[3] = {
	FileEncode = {
		provider = 'FileEncode',
		condition = condition.hide_in_width,
		separator = string.format("%s", sep.right),
		separator_highlight = { 'NONE', colors.bg },
		highlight = { colors.green, colors.bg, 'bold' }
	}
}

gls.right[4] = {
	FileFormat = {
		provider = 'FileFormat',
		condition = condition.hide_in_width,
		separator = string.format(" %s ", sep.right),
		separator_highlight = { 'NONE', colors.bg },
		highlight = { colors.green, colors.bg, 'bold' }
	}
}

gls.right[5] = {
	DiffAdd = {
		provider = function()
			local num = require('galaxyline.provider_vcs').diff_add()
			if num == nil or num == "" then
				return "0 "
			else
				return num
			end
		end,
		condition = condition.hide_in_width,
		icon = '   ',
		highlight = { colors.green, colors.bg },
		separator = string.format(" %s", sep.right),
		separator_highlight = { 'NONE', colors.bg },
	}
}

gls.right[6] = {
	DiffModified = {
		provider = function()
			local num = require('galaxyline.provider_vcs').diff_modified()
			if num == nil or num == "" then
				return "0 "
			else
				return num
			end
		end,
		condition = condition.hide_in_width,
		icon = ' 柳',
		highlight = { colors.orange, colors.bg }
	}
}
gls.right[7] = {
	DiffRemove = {
		provider = function()
			local num = require('galaxyline.provider_vcs').diff_remove()
			if num == nil or num == "" then
				return "0 "
			else
				return num
			end
		end,
		condition = condition.hide_in_width,
		icon = '  ',
		highlight = { colors.red, colors.bg }
	}
}

gls.right[8] = {
	RainbowRed = {
		provider = get_system_info,
		highlight = { colors.fg, colors.bg }
	}
}

gls.right[9] = {
	RainbowBlue = {
		provider = function()
			return ' '
		end,
		highlight = { colors.blue, colors.bg }
	}
}


gls.short_line_left[1] = {
	BufferType = {
		provider = 'FileTypeName',
		separator = ' ',
		separator_highlight = { 'NONE', colors.bg },
		highlight = { colors.blue, colors.bg, 'bold' }
	}
}

gls.short_line_left[2] = {
	SFileName = {
		provider = 'SFileName',
		condition = condition.buffer_not_empty,
		highlight = { colors.fg, colors.bg, 'bold' }
	}
}

gls.short_line_right[1] = {
	BufferIcon = {
		provider = 'BufferIcon',
		highlight = { colors.fg, colors.bg }
	}
}
