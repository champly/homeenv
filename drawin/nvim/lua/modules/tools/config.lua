local config = {}

function config.nvim_treesitter()
	vim.api.nvim_command [[ set foldmethod=expr ]]
	vim.api.nvim_command [[set foldexpr=nvim_treesitter#foldexpr()]]

	require("nvim-treesitter.configs").setup {
		ensure_installed = "all",
		ignore_install = { "swift", "wgsl", "phpdoc" },
		-- ensure_installed = { "go", "c", "cpp", "lua", "rust", "vim" },
		highlight = {
			enable = true, -- false will disable the whole extension
		},
		-- textobjects = {
		--     select = {
		--         enable = true,
		--         keymaps = {
		--             ["<leader>af"] = "@function.outer",
		--             ["<leader>if"] = "@function.inner",
		--             ["<leader>ac"] = "@class.outer",
		--             ["<leader>ic"] = "@class.inner",
		--         },
		--     },
		-- },
	}
end

function config.markdown_preview_nvim_setup()
	-- dhruvasagar/vim-table-mode
	vim.api.nvim_set_keymap("n", "<leader>kv", ":MarkdownPrevie<CR>", { noremap = true })

	vim.api.nvim_set_keymap("n", "<leader>tm", ":TableModeToggle<cr>", {})
	vim.g.table_mode_cell_text_object_i_map = "k<Bar>"
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

function config.symbols_outline()
	require("symbols-outline").setup({
		highlight_hovered_item = true,
		auto_close = false,
		auto_preview = false,
		relative_width = true,
		show_symbol_details = true,
		width = 25,
		wrap = true,
		keymaps = { -- These keymaps can be a string or a table for multiple keys
			close = { "<Esc>", "q" },
			goto_location = "<Cr>",
			focus_location = "o",
			hover_symbol = "<C-space>",
			toggle_preview = "K",
			rename_symbol = "r",
			code_actions = "a",
		},
		symbols = {
			File = { hl = "@text.uri" },
			Module = { hl = "@namespace" },
			Namespace = { hl = "@namespace" },
			Package = { hl = "@namespace" },
			Class = { hl = "@type" },
			Method = { hl = "@method" },
			Property = { hl = "@method" },
			Field = { hl = "@field" },
			Constructor = { hl = "@constructor" },
			Enum = { hl = "@type" },
			Interface = { hl = "@type" },
			Function = { hl = "@function" },
			Variable = { hl = "@constant" },
			Constant = { hl = "@constant" },
			String = { hl = "@string" },
			Number = { hl = "@number" },
			Boolean = { hl = "@boolean" },
			Array = { hl = "@constant" },
			Object = { hl = "@type" },
			Key = { hl = "@type" },
			Null = { hl = "@type" },
			EnumMember = { hl = "@field" },
			Struct = { hl = "@type" },
			Event = { hl = "@type" },
			Operator = { hl = "@operator" },
			TypeParameter = { hl = "@parameter" },
		},
	})
	vim.api.nvim_set_keymap("n", "<Space>o", ":SymbolsOutline<CR>", { noremap = true, silent = true })
	vim.cmd [[ hi FocusedSymbol gui=bold guifg=#C678DD ]]
end

-- repeat with telescope
function config.trouble()
	require("trouble").setup({
		position = "bottom",
		height = 10,
		icons = true,
		action_keys = { -- key mappings for actions in the trouble list
			-- map to {} to remove a mapping, for example:
			-- close = {},
			close = { "q", "esc>" }, -- close the list
			-- cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
			refresh = "r", -- manually refresh
			jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
			open_split = { "<c-x>" }, -- open buffer in new split
			open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
			open_tab = { "<c-t>" }, -- open buffer in new tab
			jump_close = { "o" }, -- jump to the diagnostic and close the list
			toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
			toggle_preview = "P", -- toggle auto_preview
			hover = "K", -- opens a small popup with the full multiline message
			preview = "p", -- preview the diagnostic location
			close_folds = { "zM", "zm" }, -- close all folds
			open_folds = { "zR", "zr" }, -- open all folds
			toggle_fold = { "zA", "za" }, -- toggle fold of current file
			previous = "k", -- preview item
			next = "j" -- next item
		},
	})
	vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>", { silent = true, noremap = true })
end

function config.vimspector()
	vim.g.vimspector_enable_mappings = "VISUAL_STUDIO"

	-- -- https://github.com/zunpeng/neovim/blob/master/cfgs/plug-cfg/vimspector-cfg.vim
	-- vim.api.nvim_set_keymap("n", "<leader>dt", "<CR>:lua show_vimspector_list()<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<S-s>", ":VimspectorReset<CR>", { noremap = true })

	vim.cmd [[ sign define vimspectorBP text=🛑 texthl=Normal ]]
	vim.cmd [[ sign define vimspectorBPDisabled text=🚫 texthl=Normal ]]
	vim.cmd [[ sign define vimspectorPC text=👉 texthl=SpellBad ]]
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
		on_startup = true, -- Should it be enabled by default
		hl_group = "MatchParen", -- highlight group for matched characters
		augroup_name = "matchparen", -- almost no reason to touch this unless there is already augroup with such name
	})
end

function config.dbsession()
	require("dbsession").setup({
		dir = "~/Dropbox/config/session",
		auto_save_on_exit = false,
	})
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
