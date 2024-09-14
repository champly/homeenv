local config = {}

function config.gruvbox()
	require("gruvbox").setup({
		-- https://github.com/ellisonleao/gruvbox.nvim/issues/220
		italic = {
			strings = true,
			operators = true,
			comments = true,
		},
		overrides = {
			Operator = { link = "GruvboxFg1" },
		}
	})
	vim.o.background = "dark"
	vim.cmd([[ colorscheme gruvbox ]])
end

function config.github()
	require("github-theme").setup({
		options = {
			styles = {
				comments = "italic",
			}
		}
	})
	vim.cmd([[ colorscheme github_light ]])

	-- TODO: remove this config
	vim.cmd([[ hi Delimiter guifg=black gui=none ]])
end

function config.telescope()
	-- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/config.lua
	require("telescope").setup({
		defaults = {
			prompt_prefix = "🔭 ",
			selection_caret = " ",
			sorting_strategy = "ascending",
			layout_strategy = "horizontal",
			layout_config = {
				prompt_position = "top",
				height = 0.8,
				scroll_speed = 6,
			},
			dynamic_preview_title = true,
			-- default mapping: https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua#L133
			mappings = {
				i = {
					["<C-j>"] = "preview_scrolling_left",
					["<C-f>"] = { "<Right>", type = "command" },
				},
			},
		},
		extensions = {
			fzy_native = {
				override_generic_sorter = false,
				override_file_sorter = true,
			},
			live_grep_args = {
				auto_quoting = true, -- enable/disable auto-quoting
			}
		}
	})

	require("telescope").load_extension("fzy_native")
	require("telescope").load_extension("gosource")
	require("telescope").load_extension("dotfiles")
	require("telescope").load_extension("nvimdap")
	require("telescope").load_extension("live_grep_args")

	vim.api.nvim_set_keymap("n", "<leader>fb", ":Telescope buffers<cr>", {})
	vim.api.nvim_set_keymap("n", "<leader>fh", ":Telescope oldfiles<cr>", {})
	vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<cr>", {})
	vim.api.nvim_set_keymap("n", "<leader>fw", ":Telescope live_grep<cr>", {})
	vim.api.nvim_set_keymap("n", "<leader>rg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>",
		{})
	vim.api.nvim_set_keymap("n", "<leader>fd", ":Telescope dotfiles<cr>", {})
	vim.api.nvim_set_keymap("n", "<leader>fs", ":Telescope gosource<cr>", {})
	vim.api.nvim_set_keymap("n", "<leader>dt", ":Telescope nvimdap<cr>", {})
	vim.api.nvim_set_keymap("n", "<leader>gl", ":Telescope git_bcommits<cr>", {})
end

function config.dressing()
	require("dressing").setup({
		input = {
			-- Set to false to disable the vim.ui.input implementation
			enabled = true,
			-- https://github.com/stevearc/dressing.nvim/issues/29#issuecomment-1076985525
			get_config = function()
				if vim.api.nvim_buf_get_option(0, "filetype") == "NvimTree" then
					return { enabled = false }
				end
			end,
		},
		select = {
			enabled = true,
			get_config = function(opts)
				if opts.kind == "codeaction" then
					return {
						backend = "telescope",
						telescope = require("telescope.themes").get_cursor({}),
					}
				end
			end
		}
	})
end

function config.dashboard()
	if vim.g.color_theme == vim.g.color_theme_dark then
		vim.cmd [[ hi DashboardHeader guifg=yellow ]]
		vim.cmd [[ hi DashboardFooter guifg=gray ]]

		vim.cmd [[ hi DashboardIcon guifg=yellow ]]
		vim.cmd [[ hi DashboardDesc guifg=yellow ]]
		vim.cmd [[ hi DashboardShotCut guifg=#1E90FF ]]
		vim.cmd [[ hi DashboardKey guifg=#1E90FF ]]
	else
		vim.cmd [[ hi DashboardHeader guifg=orange ]]
		vim.cmd [[ hi DashboardFooter guifg=gray ]]

		vim.cmd [[ hi DashboardIcon guifg=orange ]]
		vim.cmd [[ hi DashboardDesc guifg=orange ]]
		vim.cmd [[ hi DashboardShotCut guifg=#1E90FF ]]
		vim.cmd [[ hi DashboardKey guifg=#1E90FF ]]
	end

	require("dashboard").setup({
		theme = "doom",
		config = {
			header = {
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
				string.format(
					"v%s.%s.%s%s",
					vim.version().major,
					vim.version().minor,
					vim.version().patch,
					vim.version().api_prerelease and "-dev" or ""
				),
				"",
				"",
			},
			center = {
				{
					icon = "  ",
					desc = "Recently laset session                  ",
					key = "<leader>sl",
					action = [[ lua require("persistence").load() ]]
				},
				{
					icon = "  ",
					desc = "Recently opened files                   ",
					key = "<leader>fh",
					action = "Telescope oldfiles"
				},
				{
					icon = "  ",
					desc = "Find  File                              ",
					key = "<leader>ff",
					action = "Telescope find_files"
				},
				{
					icon = "  ",
					desc = "Find  word                              ",
					key = "<leader>fw",
					action = "Telescope live_grep"
				},
				{
					icon = "  ",
					desc = "Create new buffer                       ",
					key = "<leader> n",
					action = "enew"
				},
				{
					icon = "  ",
					desc = "Open Personal dotfiles                  ",
					key = "<leader>fd",
					action = "Telescope dotfiles"
				},
				{
					icon = "  ",
					desc = "Find Go Source Code                     ",
					key = "<leader>fs",
					action = "Telescope gosource"
				},
			},
			footer = {
				"",
				"",
				"If you think penguins are fat and waddle, you have never been attacked by one",
				"running at you in excess of 100 miles per hour.",
				"",
				"                                                            -- Linus Torvalds",
			}
		}
	})

	vim.api.nvim_set_keymap("n", "<leader>fh", ":Telescope oldfiles<cr>", {})
	vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<cr>", {})
	vim.api.nvim_set_keymap("n", "<leader>fw", ":Telescope live_grep<cr>", {})
	vim.api.nvim_set_keymap("n", "<leader>fd", ":Telescope dotfiles<cr>", {})
	vim.api.nvim_set_keymap("n", "<leader>fs", ":Telescope gosource<cr>", {})
	vim.api.nvim_set_keymap("n", "<leader>lm", ":Telescope marks<cr>", {})
end

function config.nvim_tree()
	-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Migrating-To-on_attach
	local function on_attach(bufnr)
		local api = require("nvim-tree.api")

		local function opts(desc)
			return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		end

		-- default mappings
		api.config.mappings.default_on_attach(bufnr)

		-- custom mappings
		vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
		vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
	end

	-- vim.api.nvim_set_keymap("n", "ff", ":NvimTreeToggle<CR>", { noremap = true })
	vim.api.nvim_set_keymap("n", "ff", ":NvimTreeFindFile<CR>", { noremap = true })

	-- https://github.com/nvim-tree/nvim-tree.lua/pull/603
	-- https://github.com/nvim-tree/nvim-tree.lua/issues/674
	require("nvim-tree").setup {
		renderer = {
			indent_markers = {
				enable = true,
			},
			icons = {
				show = {
					folder_arrow = false,
				},
				glyphs = {
					git = {
						-- renamed = "➜",
						-- deleted = "",
						renamed = "≫",
						deleted = "≠",
					},
				}
			},
			special_files = {}
		},
		update_focused_file = {
			enable = true
		},
		filters = {
			git_ignored = false,
			dotfiles = true
		},
		actions = {
			open_file = {
				-- Closes the explorer when opening a file.
				quit_on_open = false,
			},
		},
		view = {
			adaptive_size = true,
			-- width = "16%",
			side = "left",
		},
		on_attach = on_attach,
	}

	vim.cmd [[ hi NvimTreeFolderIcon guifg=#DAA520 ]]
end

function config.neo_tree()
	require("neo-tree").setup({
		filesystem = {
			follow_current_file = {
				enabled = true,
			},
		},
	})

	vim.cmd([[nnoremap ff :Neotree reveal<cr>]])
end

function config.bufferline()
	-- https://github.com/akinsho/bufferline.nvim#configuration
	require("bufferline").setup {
		options = {
			numbers = function(opts)
				return string.format("%s.", opts.ordinal)
			end,
			modified_icon = "✥",
			buffer_close_icon = "",
			always_show_bufferline = false,
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					highlight = "Directory",
					separator = true -- use a "true" to enable the default, or set your own character
				}
			}
		}
	}

	local cmd = "nnoremap <silent><leader>%d <cmd>lua require('bufferline').go_to(%d, true)<cr>"
	for i = 1, 9, 1 do
		vim.cmd(string.format(cmd, i, i))
	end
end

function config.feline_nvim()
	if vim.g.color_theme == vim.g.color_theme_dark then
		vim.cmd [[ hi StatusLineNC guibg=#696157 gui=none ]]
	else
		vim.cmd [[ hi StatusLineNC guibg=#fce5cd gui=none ]]
	end
	require("modules.ui.statusline.layout")
end

function config.gitsigns_nvim()
	-- https://github.com/lewis6991/gitsigns.nvim/issues/430
	vim.cmd [[ highlight gitsignscurrentlineblame guibg=None guifg=#756969]]

	require("gitsigns").setup({
		signs                   = {
			-- add          = { text = '│' },
			change       = { text = '▒' },
			-- delete       = { text = '_' },
			-- topdelete    = { text = '‾' },
			changedelete = { text = '░' },
			-- untracked    = { text = '┆' },
		},
		current_line_blame      = true,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
			delay = 0,
			ignore_whitespace = true
		},
	})
end

function config.toggleterm()
	require("toggleterm").setup({
		size = function(term)
			if term.direction == "horizontal" then
				return 12
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			else
				return 20
			end
		end,
		open_mapping = "<F3>",
		-- 'vertical' | 'horizontal' | 'tab' | 'float'
		direction = "float"
	})

	-- 在终端中，你可以按下<C-\><C-n>（也就是按下Ctrl+\然后按下Ctrl+n）来进入正常模式
end

function config.nvim_notify()
	---@diagnostic disable-next-line: param-type-mismatch
	vim.notify = vim.schedule_wrap(require("notify"))

	---@diagnostic disable-next-line: duplicate-set-field
	function _G.save_file_with_notify()
		---@diagnostic disable-next-line: param-type-mismatch
		local ok, msg = pcall(vim.cmd, "silent write!")
		if ok then
			vim.notify("Saved " .. vim.fn.expand "%:t", nil, {
				title = "Success",
				timeout = 1000
			})
		else
			---@diagnostic disable-next-line: param-type-mismatch
			vim.notify(msg, "error", {
				title = "Error",
				timeout = 1000
			})
		end
	end

	vim.api.nvim_set_keymap("n", "<leader>s", "<cmd>lua save_file_with_notify()<cr>", { noremap = true, silent = true })
end

function config.which_key()
	require("which-key").setup {
	}
end

return config
