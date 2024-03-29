local config = {}

function config.gruvbox()
	-- vim.g.gruvbox_italic = 1
	-- vim.cmd("set background=dark")
	-- vim.cmd("colorscheme gruvbox")
	require("gruvbox").setup({
		italic = true,
		overrides = {
			-- Operator = { fg = colors.orange, italic = config.italic },
			-- Operator = { fg = "#fe8019", italic = false },
			Operator = { link = "GruvboxFg1" },
		}
	})
	vim.o.background = "dark"
	vim.cmd([[ colorscheme gruvbox ]])
end

function config.dashboard()
	vim.cmd [[ hi DashboardHeader guifg=yellow ]]
	vim.cmd [[ hi DashboardCenter guifg=yellow ]]
	vim.cmd [[ hi DashboardShortcut guifg=#1E90FF ]]
	vim.cmd [[ hi DashboardFooter guifg=gray ]]

	local db = require("dashboard")
	db.custom_header = {
		"",
		"",
		"",
		"  ______         __                                      __     __           __            _                        __                             ",
		" /_  __/___     / /_  ___     ____  _____   ____  ____  / /_   / /_____     / /_  ___     (_)____   __  ______     / /_____     __  ______  __  __ ",
		"  / / / __ \\   / __ \\/ _ \\   / __ \\/ ___/  / __ \\/ __ \\/ __/  / __/ __ \\   / __ \\/ _ \\   / / ___/  / / / / __ \\   / __/ __ \\   / / / / __ \\/ / / / ",
		" / / / /_/ /  / /_/ /  __/  / /_/ / /     / / / / /_/ / /_   / /_/ /_/ /  / /_/ /  __/  / (__  )  / /_/ / /_/ /  / /_/ /_/ /  / /_/ / /_/ / /_/ /  ",
		"/_/  \\____/  /_.___/\\___/   \\____/_/     /_/ /_/\\____/\\__/   \\__/\\____/  /_.___/\\___/  /_/____/   \\__,_/ .___/   \\__/\\____/   \\__, /\\____/\\__,_/   ",
		"                                                                                                      /_/                    /____/                ",
		"",
		"",
	}
	db.custom_center = {
		{
			icon = "  ",
			desc = "Recently laset session                  ",
			shortcut = "<leader>sl",
			action = "SessionLoad"
		},
		{
			icon = "  ",
			desc = "Recently opened files                   ",
			shortcut = "<leader>fh",
			action = "Telescope oldfiles"
		},
		{
			icon = "  ",
			desc = "Find  File                              ",
			shortcut = "<leader>ff",
			action = "Telescope find_files"
		},
		{
			icon = "  ",
			desc = "Find  word                              ",
			shortcut = "<leader>fw",
			action = "Telescope live_grep"
		},
		{
			icon = "  ",
			desc = "Create new buffer                       ",
			shortcut = "<leader> n",
			action = "enew"
		},
		{
			icon = "  ",
			desc = "Open Personal dotfiles                  ",
			shortcut = "<leader>fd",
			action = "Telescope dotfiles"
		},
		{
			icon = "  ",
			desc = "Find Go Source Code                     ",
			shortcut = "<leader>fs",
			action = "Telescope gosource"
		},
	}
	db.custom_footer = {
		"",
		"",
		"If you think penguins are fat and waddle, you have never been attacked by one",
		"running at you in excess of 100 miles per hour.",
		"",
		"                                                            -- Linus Torvalds",
	}
	db.session_directory = "/Users/champly/Dropbox/config/session"

	vim.api.nvim_set_keymap("n", "<leader>fh", ":Telescope oldfiles<cr>", {})
	vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<cr>", {})
	vim.api.nvim_set_keymap("n", "<leader>fw", ":Telescope live_grep<cr>", {})
	vim.api.nvim_set_keymap("n", "<leader>fd", ":Telescope dotfiles<cr>", {})
	vim.api.nvim_set_keymap("n", "<leader>fs", ":Telescope gosource<cr>", {})
end

function config.nvim_tree()
	-- https://github.com/kyazdani42/nvim-tree.lua/pull/603
	-- https://github.com/kyazdani42/nvim-tree.lua/issues/674
	require("nvim-tree").setup {
		update_cwd = true,
		update_focused_file = {
			enable = true,
			update_cwd = false
		},
		renderer = {
			indent_markers = {
				enable = true,
				icons = {
					corner = "└",
					edge = "│",
					item = "│",
					none = " ",
				},
			},
			icons = {
				show = {
					file = true,
					folder = true,
					folder_arrow = false,
					git = true,
				},
				glyphs = {
					git = {
						unstaged = "✗",
						staged = "✓",
						unmerged = "",
						-- renamed = "➜",
						renamed = "≫",
						untracked = "★",
						deleted = "≠",
						ignored = "◌"
					},
				}
			},
			special_files = {}
		},
		diagnostics = {
			enable = false,
			show_on_dirs = false,
			icons = {
				hint = "",
				info = "",
				warning = "",
				error = ""
			}
		},
		filters = {
			dotfiles = true
		},
		actions = {
			change_dir = {
				enable = true,
				global = false
			},
			open_file = {
				quit_on_open = true,
				resize_window = true,
			},
		},
		view = {
			adaptive_size = true,
			-- width = "16%",
			side = "left",
			mappings = {
				list = {
					{ key = { "<CR>", "o" }, action = "edit" },
					{ key = { "v" }, action = "vsplit" },
					{ key = { "s" }, action = "split" },
				}
			}
		}
	}

	local bind = require("utils.bind")
	bind.nvim_load_mapping({
		["n|ff"] = bind.map_cr("NvimTreeToggle"):with_noremap()
	})
end

function config.galaxyline()
	require("modules.ui.eviline")
end

function config.feline_nvim()
	vim.cmd [[ hi StatusLineNC guibg=#696157 gui=none ]]
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
			modified_icon = "✥",
			buffer_close_icon = "",
			always_show_bufferline = false
		}
	}

	local cmd = "nnoremap <silent><leader>%d <Cmd>BufferLineGoToBuffer %d<CR>"
	for i = 1, 9, 1 do
		vim.cmd(string.format(cmd, i, i))
	end
end

function config.vim_gitgutter()
	vim.g.gitgutter_diff_args = '-w'

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
		["n|<leader>gf"] = bind.map_cr("GitGutterFold"):with_noremap()
	})
end

function config.gitsigns_nvim()
	-- https://github.com/lewis6991/gitsigns.nvim/issues/430
	vim.cmd [[ highlight gitsignscurrentlineblame guibg=None guifg=#756969]]

	require('gitsigns').setup({
		signs = {
			add = {
				hl = 'GitSignsAdd',
				text = '│',
				numhl = 'GitSignsAddNr',
				linehl = 'GitSignsAddLn'
			},
			change = {
				hl = 'GitSignsChange',
				text = '▒',
				numhl = 'GitSignsChangeNr',
				linehl = 'GitSignsChangeLn'
			},
			delete = {
				hl = 'GitSignsDelete',
				text = '_',
				numhl = 'GitSignsDeleteNr',
				linehl = 'GitSignsDeleteLn'
			},
			topdelete = {
				hl = 'GitSignsDelete',
				text = '‾',
				numhl = 'GitSignsDeleteNr',
				linehl = 'GitSignsDeleteLn'
			},
			changedelete = {
				hl = 'GitSignsChange',
				text = '░',
				numhl = 'GitSignsChangeNr',
				linehl = 'GitSignsChangeLn'
			}
		},
		current_line_blame = true,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
			delay = 0,
			ignore_whitespace = true
		},
		current_line_blame_formatter_opts = {
			relative_time = true
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
		["t|<F3>"] = bind.map_cmd("<C-\\><C-n>:FloatermToggle<CR>"):with_noremap()
	})
end

function config.nvim_notify()
	vim.notify = require("notify")

	function _G.save_file_with_notify()
		local ok, msg = pcall(vim.cmd, "silent write!")
		if ok then
			vim.notify("Saved " .. vim.fn.expand "%:t", nil, {
				title = "Success",
				timeout = 1000
			})
		else
			vim.notify(msg, "error", {
				title = "Error",
				timeout = 1000
			})
		end
	end

	local bind = require("utils.bind")
	bind.nvim_load_mapping({
		["n|<leader>s"] = bind.map_cmd("<cmd>lua save_file_with_notify()<cr>"):with_noremap():with_silent()
	})
end

function config.rainbow()
	vim.g.rainbow_active = 1 -- set to 0 if you want to enable it later via :RainbowToggle

	-- 使用 vim-devicons 之后文件见有中括号
	-- https://github.com/ryanoasis/vim-devicons/issues/274#issuecomment-513560707
	vim.g.rainbow_conf = {
		separately = {
			nerdtree = 0
		}
	}
end

function config.nvim_ts_rainbow()
	-- https://github.com/p00f/nvim-ts-rainbow#installation-and-setup
	require("nvim-treesitter.configs").setup({
		rainbow = {
			enable = true
		}
	})
end

function config.beacon()
	vim.cmd [[ highlight Beacon guibg=blue ctermbg=15 ]]
end

function config.which_key()
	require("which-key").setup {
	}
end

return config
