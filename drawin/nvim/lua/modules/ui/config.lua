local config = {}

function config.gruvbox()
	vim.g.gruvbox_italic = 1
	vim.cmd("set background=dark")
	vim.cmd("colorscheme gruvbox")
end

function config.dashboard()
	-- vim.g=dashboard_preview_command = "cat"
	-- vim.g.dashboard_preview_pipeline = "lolcat"
	-- vim.g.dashboard_preview_file = "~/.config/nvim/static/champly.txt"
	-- vim.g.dashboard_preview_file_height = 12
	-- vim.g.dashboard_preview_file_width = 58
	vim.g.dashboard_default_executive = "telescope"
	-- vim.g.dashboard_default_executive = "fzf"

	vim.g.dashboard_custom_header = {
		'',
		'',
		'',
		'  ______         __                                      __     __           __            _                        __                             ',
		' /_  __/___     / /_  ___     ____  _____   ____  ____  / /_   / /_____     / /_  ___     (_)____   __  ______     / /_____     __  ______  __  __ ',
		'  / / / __ \\   / __ \\/ _ \\   / __ \\/ ___/  / __ \\/ __ \\/ __/  / __/ __ \\   / __ \\/ _ \\   / / ___/  / / / / __ \\   / __/ __ \\   / / / / __ \\/ / / / ',
		' / / / /_/ /  / /_/ /  __/  / /_/ / /     / / / / /_/ / /_   / /_/ /_/ /  / /_/ /  __/  / (__  )  / /_/ / /_/ /  / /_/ /_/ /  / /_/ / /_/ / /_/ /  ',
		'/_/  \\____/  /_.___/\\___/   \\____/_/     /_/ /_/\\____/\\__/   \\__/\\____/  /_.___/\\___/  /_/____/   \\__,_/ .___/   \\__/\\____/   \\__, /\\____/\\__,_/   ',
		'                                                                                                      /_/                    /____/                ',
		'',
	}

	-- vim.g.dashboard_footer_icon = "🐬 "
	vim.g.dashboard_custom_footer = {
		"If you think penguins are fat and waddle, you have never been attacked by one",
		"running at you in excess of 100 miles per hour.",
		"",
		"                                                            -- Linus Torvalds",
	}

	vim.g.dashboard_custom_section = {
		last_session = {
			description = { "  Recently laset session                  leader sl" },
			command = "SessionLoad",
		},
		find_history = {
			description = { "  Recently opened files                   leader fh" },
			command = "DashboardFindHistory",
		},
		find_file = {
			description = { "  Find  File                              leader ff" },
			command = "DashboardFindFile",
		},
		find_word = {
			description = { "  Find  word                              leader fw" },
			command = "DashboardFindWord",
		},
		new_buffer = {
			description = { "  Create new buffer                       leader n " },
			command = "=enew",
		},
		find_dotfiles = {
			description = { "  Open Personal dotfiles                  leader fd" },
			command = "Telescope dotfiles",
		},
		go_source = {
			description = { "  Find Go Source Code                     leader fs" },
			command = "Telescope gosource",
		},
	}

	vim.cmd [[ hi DashboardShortcut guifg=#1E90FF ]]
	vim.cmd [[ hi DashboardFooter guifg=gray ]]

	local bind = require("utils.bind")
	bind.nvim_load_mapping({
		["n|<leader>fh"] = bind.map_cr("DashboardFindHistory"):with_noremap():with_silent(),
		["n|<leader>fw"] = bind.map_cr("DashboardFindWord"):with_noremap():with_silent(),
		["n|<leader>ff"] = bind.map_cr("DashboardFindFile"):with_noremap():with_silent(),
	})
end

function config.nvim_tree()
	vim.g.nvim_tree_quit_on_open = 1
	vim.g.nvim_tree_indent_markers = 1
	-- vim.g.nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } -- List of filenames that gets highlighted with NvimTreeSpecialFile
	vim.g.nvim_tree_special_files = {}

	local tree_cb = require("nvim-tree.config").nvim_tree_callback
	local list = {
		{ key = {"<CR>","o"}, cb = tree_cb("edit")},
		{ key = {"v"}, cb = tree_cb("vsplit")},
		{ key = {"s"}, cb = tree_cb("split")},
	}

	vim.g.nvim_tree_icons = {
		default =  '',
		symlink =  '',
		git = {
			-- unstaged = "✚",
			-- staged =  "✚",
			-- unmerged =  "≠",
			-- renamed =  "≫",
			-- untracked = "★",
			unstaged = "≠",
			staged = "✓",
			unmerged = "",
			renamed = "➜",
			untracked = "★",
			deleted = "",
			ignored = "◌"
		},
		lsp = {
			hint= "",
			info= "",
			warning= "",
			error = "",
		}
	}

	-- https://github.com/kyazdani42/nvim-tree.lua/pull/603
	require("nvim-tree").setup {
		auto_close = true,
		update_cwd = true,
		update_focused_file = {
			enable = true,
		},
		filters = {
			dotfiles = true,
		},
		view = {
			width = "19%",
			side = "left",
			auto_resize = true,
			mappings = {
				list = list,
			},
		}
	}

	local bind = require("utils.bind")
	bind.nvim_load_mapping({
		["n|ff"] = bind.map_cr("NvimTreeToggle"):with_noremap(),
	})
end

function config.galaxyline()
	require("modules.ui.eviline")
end

function config.feline_nvim()
	require("modules.ui.statusline.layout")
	-- require("modules.ui.statusline.nvchad")
end

function config.bufferline()
	-- https://github.com/akinsho/bufferline.nvim#configuration
	vim.opt.termguicolors = true
	require("bufferline").setup {
		options = {
			numbers = function(opts)
				return string.format('%s.', opts.ordinal)
			end,
			modified_icon = '✥',
			buffer_close_icon = '',
			always_show_bufferline = false,
		},
	}

	local cmd = "nnoremap <silent><leader>%d <Cmd>BufferLineGoToBuffer %d<CR>"
	for	i = 1, 9, 1 do
		vim.cmd(string.format(cmd, i, i))
	end
end

function config.vim_gitgutter()
	vim.g.gitgutter_diff_args = '-w'

	-- highlight! link SignColumn LineNr
	-- highlight GitGutterAdd	  guifg=#009900 ctermfg=2
	-- highlight GitGutterChange guifg=#bbbb00 ctermfg=3
	-- highlight GitGutterDelete guifg=#ff2222 ctermfg=1
	-- vim.g.gitgutter_set_sign_backgrounds = 1

	vim.g.gitgutter_sign_allow_clobber = 0
	vim.g.gitgutter_map_keys = 0
	vim.g.gitgutter_override_sign_column_highlight = 0
	vim.g.gitgutter_preview_win_floating = 1
	vim.g.gitgutter_sign_added = '▎'
	vim.g.gitgutter_sign_modified = '░'
	vim.g.gitgutter_sign_removed = '▏'
	vim.g.gitgutter_sign_removed_first_line = '▔'
	vim.g.gitgutter_sign_modified_removed = '▒'


	-- -- 有时会出现git左侧状态栏不准确的问题 使用该命令可以强制刷新
	-- nmap <silent> <leader>ll :GitGutterAll<CR>
	-- nnoremap <leader>gf :GitGutterFold<CR>
	-- -- nnoremap H :GitGutterPreviewHunk<CR>
	-- -- nnoremap <leader>g- :GitGutterPrevHunk<CR>
	-- -- nnoremap <leader>g= :GitGutterNextHunk<CR>

	-- 有时会出现git左侧状态栏不准确的问题 使用该命令可以强制刷新
	local bind = require("utils.bind")
	bind.nvim_load_mapping({
		["n|<leader>ll"] = bind.map_cr("GitGutterAll"):with_silent(),
		["n|<leader>gf"] = bind.map_cr("GitGutterFold"):with_noremap(),
	})
end

function config.gitsigns_nvim()
	-- vim.cmd [[ highlight link GitSignsCurrentLineBlame Visual ]]
	require('gitsigns').setup({
		signs = {
			add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
			change       = {hl = 'GitSignsChange', text = '▒', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
			delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
			topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
			changedelete = {hl = 'GitSignsChange', text = '░', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
		},
		current_line_blame = true,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
			delay = 0,
			ignore_whitespace = true,
		},
		current_line_blame_formatter_opts = {
			relative_time = true,
		}
	})
end

function config.vim_floaterm()
	vim.g.floaterm_title = "zsh $1/$2"
	vim.g.floaterm_autoclose = 1
	vim.g.floaterm_width = 0.8
	vim.g.floaterm_height = 0.8

	local bind = require("utils.bind")
	bind.nvim_load_mapping({
		["n|<F3>"] = bind.map_cr("FloatermToggle"):with_noremap(),
		["t|<F3>"] = bind.map_cmd("<C-\\><C-n>:FloatermToggle<CR>"):with_noremap(),
	})
end

function config.nvim_notify()
	vim.notify = require("notify")

	function _G._save_file()
		local ok, msg = pcall(vim.cmd, "silent write!")
		if ok then
			vim.notify("Saved " .. vim.fn.expand "%:t", nil, { title = "Success", timeout = 1000 })
		else
			vim.notify(msg, "error", { title = "Error", timeout = 1000 })
		end
	end

	local bind = require("utils.bind")
	bind.nvim_load_mapping({
		["n|<leader>s"] = bind.map_cmd("<cmd>lua _save_file()<cr>"):with_noremap():with_silent(),
	})
end

return config
