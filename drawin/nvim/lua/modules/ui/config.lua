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
	require("github-theme").setup()
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
					icon = "  ",
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

		-- Default mappings. Feel free to modify or remove as you wish.
		--
		-- BEGIN_DEFAULT_ON_ATTACH
		vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
		vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
		vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
		vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
		vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
		vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
		vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
		vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory"))
		vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
		vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
		vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
		vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
		vim.keymap.set("n", ".", api.node.run.cmd, opts("Run Command"))
		vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
		vim.keymap.set("n", "a", api.fs.create, opts("Create"))
		vim.keymap.set("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked"))
		vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts("Toggle No Buffer"))
		vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
		vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts("Toggle Git Clean"))
		vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
		vim.keymap.set("n", "]c", api.node.navigate.git.next, opts("Next Git"))
		vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
		vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))
		vim.keymap.set("n", "E", api.tree.expand_all, opts("Expand All"))
		vim.keymap.set("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
		vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
		vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
		vim.keymap.set("n", "F", api.live_filter.clear, opts("Clean Filter"))
		vim.keymap.set("n", "f", api.live_filter.start, opts("Filter"))
		vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))
		vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
		vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
		vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
		vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
		vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
		vim.keymap.set("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
		vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
		vim.keymap.set("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
		vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
		vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory"))
		vim.keymap.set("n", "q", api.tree.close, opts("Close"))
		vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
		vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
		vim.keymap.set("n", "s", api.node.run.system, opts("Run System"))
		vim.keymap.set("n", "S", api.tree.search_node, opts("Search"))
		vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts("Toggle Hidden"))
		vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse"))
		vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
		vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
		vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
		vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
		vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
		-- END_DEFAULT_ON_ATTACH

		-- Mappings migrated from view.mappings.list
		--
		-- You will need to insert "your code goes here" for any mappings with a custom action_cb
		vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
		vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
	end

	vim.api.nvim_set_keymap("n", "ff", ":NvimTreeToggle<CR>", { noremap = true })

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
				quit_on_open = true,
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
			always_show_bufferline = false
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
