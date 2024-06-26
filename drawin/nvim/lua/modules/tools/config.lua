local config = {}

function config.nvim_treesitter()
	vim.api.nvim_command [[ set foldmethod=expr ]]
	vim.api.nvim_command [[ set foldexpr=nvim_treesitter#foldexpr() ]]

	---@diagnostic disable-next-line: missing-fields
	require("nvim-treesitter.configs").setup({
		-- ensure_installed = "all",
		-- ignore_install = { "swift", "wgsl", "phpdoc" },
		ensure_installed = {
			"lua",
			"go",
			"gomod",
			"gosum",
			"gowork",
			"c",
			"cpp",
			"rust",
			"vim",
			"proto",
			"dockerfile",
			"markdown",
			"markdown_inline",
			"json",
			"jsonc",
			"yaml",
			"bash",
		},
		highlight = {
			enable = true, -- false will disable the whole extension
			disable = function(_, buf)
				return vim.api.nvim_buf_line_count(buf) > 6000
			end,
		},
	})
end

function config.markdown_preview_nvim_setup()
	-- dhruvasagar/vim-table-mode
	vim.api.nvim_set_keymap("n", "<leader>kv", ":MarkdownPrevie<CR>", { noremap = true })

	vim.api.nvim_set_keymap("n", "<leader>tm", ":TableModeToggle<cr>", {})
	vim.g.table_mode_cell_text_object_i_map = "k<Bar>"
end

function config.headlines_nvim()
	-- vim.cmd [[highlight Headline1 guibg=#1e2718]]
	-- vim.cmd [[highlight Headline2 guibg=#21262d]]
	-- vim.cmd [[highlight CodeBlock guibg=#1c1c1c]]
	-- vim.cmd [[highlight Dash guibg=#D19A66 gui=bold]]

	require("headlines").setup({
		markdown = {
			fat_headline_lower_string = "▀",
			-- headline_highlights = { "Headline1", "Headline2" },
		},
	})
end

function config.undotree()
	-- nnoremap <Leader>u :UndotreeToggle<CR>
	vim.api.nvim_set_keymap("n", "<leader>u", ":UndotreeToggle<cr>", { noremap = true })
	-- If set to 1, the undotree window will get focus after being opened, otherwise focus will stay in current window.
	vim.g.undotree_SetFocusWhenToggle = 1
end

function config.vimwiki_setup()
	vim.g.vimwiki_list = {
		{
			path = "~/Dropbox/notebook/vimwiki/",
			syntax = "markdown",
			ext = ".md"
		}
	}

	vim.api.nvim_set_keymap("n", "<leader>wd", ":VimwikiMakeDiaryNote<cr>", { silent = true })
	vim.api.nvim_set_keymap("n", "<leader>ww", ":VimwikiIndex<cr>", { silent = true })
end

function config.vim_visual_multi_setup()
	vim.g.VM_show_warnings = 0
	vim.g.VM_leader = "\\"
	vim.g.VM_maps = {
		Undo = "u",
		Redo = "<C-r>",
		["Add Cursor Down"] = "<M-j>", -- 往下增加光标 Opt+j
		["Add Cursor Up"] = "<M-k>", -- 往上增加光标 Opt+k
		-- ["Select All"] = '\\A',
	}
	vim.g.VM_no_meta_mappings = {
	}

	-- Opt+h Opt+l 在多光标模式下 可以移动单个光标 而不是所有光标
	vim.api.nvim_set_keymap("n", "<M-h>", "<Left>", {})
	vim.api.nvim_set_keymap("n", "<M-l>", "<Right>", {})
end

function config.hop_nvim()
	require("hop").setup({
		keys = ";sftunq/SFGHLTUNRMQZ?0123456789",
	})
end

function config.hop_nvim_setup()
	-- https://github.com/phaazon/hop.nvim#keybindings
	-- place this in one of your configuration file(s)
	vim.api.nvim_set_keymap('n', 'f',
		"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false })<cr>"
		, {})
	vim.api.nvim_set_keymap('n', 'F',
		"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false })<cr>"
		, {})
	vim.api.nvim_set_keymap('v', 'f',
		"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false })<cr>"
		, {})
	vim.api.nvim_set_keymap('v', 'F',
		"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false })<cr>"
		, {})
end

function config.outline_nvim()
	require("outline").setup({
		outline_window = {
			auto_close = true,
			wrap = true,
		},
	})
	vim.api.nvim_set_keymap("n", "<space>o", ":Outline<cr>", { noremap = true, silent = true })
	vim.cmd [[ hi OutlineCurrent gui=bold guifg=blue ]]
end

function config.nvim_dap()
	vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "Normal", linehl = "", numhl = "" })
	vim.fn.sign_define("DapBreakpointRejected", { text = "🚫", texthl = "Normal", linehl = "", numhl = "" })
	vim.fn.sign_define("DapStopped", { text = "👉", texthl = "Normal", linehl = "", numhl = "" })

	vim.keymap.set("n", "<F5>", function() require("dap").continue() end)
	vim.keymap.set("n", "<F9>", function() require("dap").toggle_breakpoint() end)
	vim.keymap.set("n", "<F10>", function() require("dap").step_over() end)
	vim.keymap.set("n", "<F11>", function() require("dap").step_into() end)
	vim.keymap.set("n", "<F12>", function() require("dap").step_out() end)
	vim.keymap.set("n", "<S-s>", function() require("dap").terminate() end)
	-- vim.keymap.set("n", "<leader>ll",
	--     function() require("dap.ext.vscode").load_launchjs(nil, { codelldb = { "rust", dlv = { "go" } } }) end)

	local dap = require("dap")

	dap.adapters.delve = {
		type = "server",
		port = "${port}",
		executable = {
			command = "dlv",
			args = { "dap", "-l", "127.0.0.1:${port}" },
		}
	}
	dap.adapters.codelldb = {
		type = "server",
		port = "${port}",
		executable = {
			command = "codelldb",
			args = { "--port", "${port}" },
		}
	}

	-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
	dap.configurations.go = {
		{
			type = "delve",
			name = "Debug (Default)",
			request = "launch",
			program = "${file}"
		},
		{
			type = "delve",
			name = "Debug test (Default)", -- configuration for debugging test files
			request = "launch",
			mode = "test",
			program = "${file}"
		},
		-- works with go.mod packages and sub packages
		{
			type = "delve",
			name = "Debug test (go.mod Default)",
			request = "launch",
			mode = "test",
			program = "./${relativeFileDirname}"
		}
	}

	dap.configurations.rust = {
		{
			name = "Launch file (Default)",
			type = "codelldb",
			request = "launch",
			program = "${workspaceFolder}/target/debug/${workspaceFolderBasename}",
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
		},
	}
	dap.configurations.cpp = {
		{
			name = "Launch file",
			type = "codelldb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
		},
	}
	dap.configurations.c = dap.configurations.cpp

	-- auto reload .vscode/launch.json
	local type_to_filetypes = { codelldb = { "rust" }, delve = { "go" } }
	require("dap.ext.vscode").load_launchjs(nil, type_to_filetypes)

	local pattern = "*/.vscode/launch.json"
	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = pattern,
		callback = function(args)
			require("dap.ext.vscode").load_launchjs(args.file, type_to_filetypes)
		end
	})
end

function config.nvim_dap_ui()
	require("dapui").setup()
	local dap, dapui = require("dap"), require("dapui")
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end
end

function config.autopairs()
	local present1, autopairs = pcall(require, "nvim-autopairs")
	local present2, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")

	if present1 and present2 then
		autopairs.setup({
			disable_filetype = { "TelescopePrompt", "vim" },
		})

		local cmp = require "cmp"
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	else
		autopairs.setup({
			disable_filetype = { "TelescopePrompt", "vim" },
		})
	end
end

function config.smoothie_setup()
	vim.g.smoothie_remapped_commands = {
		"<C-D>",
		"<C-U>",
		"<C-F>",
		"<S-Down>",
		"<PageDown>",
		"<C-B>",
		"<S-Up>",
		"<PageUp>",
		"z+",
		"z^",
		"z<CR>",
		"z.",
		"z-",
		-- "zt",
		-- "zz",
		-- "zb",
	}
end

function config.matchparen()
	require("matchparen").setup({
		on_startup = true,     -- Should it be enabled by default
		hl_group = "MatchParen", -- highlight group for matched characters
		augroup_name = "matchparen", -- almost no reason to touch this unless there is already augroup with such name
	})
end

function config.nvim_spectre()
	-- vim.api.nvim_set_keymap("n", "<leader>S", "<cmd>lua require('spectre').open()<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<leader>S", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
		{ noremap = true, silent = true })
end

function config.neoformat()
	-- Enable alignment
	vim.g.neoformat_basic_format_align = 1
	-- Enable tab to spaces conversion
	vim.g.neoformat_basic_format_retab = 1
	-- Enable trimmming of trailing whitespace
	vim.g.neoformat_basic_format_trim = 1
end

return config
