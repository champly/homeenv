local config = {}

function config.nvim_treesitter()
	vim.api.nvim_command [[ set foldmethod=expr ]]
	vim.api.nvim_command [[set foldexpr=nvim_treesitter#foldexpr()]]

	require("nvim-treesitter.configs").setup {
		ensure_installed = "all",
		ignore_install = { "swift", "wgsl", "phpdoc" },
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

function config.markdown_preview_nvim()
	-- auto open browser
	-- vim.g.mkdp_auto_start = 1
	vim.api.nvim_set_keymap("n", "<leader>kv", ":MarkdownPrevie<CR>", { noremap = true })

	-- dhruvasagar/vim-table-mode
	vim.g.table_mode_cell_text_object_i_map = "k<Bar>"
	vim.api.nvim_set_keymap("n", "<leader>tm", ":TableModeToggle<cr>", {})
end

function config.undotree()
	-- nnoremap <Leader>u :UndotreeToggle<CR>
	vim.api.nvim_set_keymap("n", "<leader>u", ":UndotreeToggle<cr>", { noremap = true })
	-- If set to 1, the undotree window will get focus after being opened, otherwise focus will stay in current window.
	vim.g.undotree_SetFocusWhenToggle = 1
end

function config.vimwiki()
	vim.g.vimwiki_list = {
		{
			path = "~/Dropbox/notebook/vimwiki/",
			syntax = "markdown",
			ext = ".md"
		}
	}
end

function config.far_vim()
	vim.cmd [[ set lazyredraw ]] -- improve scrolling performance when navigating through large results
	vim.cmd [[ set regexpengine=1 ]] -- use old regexp engine
	vim.cmd [[ set ignorecase smartcase ]] -- ignore case only when the pattern contains no capital letters

	-- -- shortcut for far.vim find
	-- vim.cmd [[ nnoremap <silent> <Find-Shortcut>  :Farf<cr> ]]
	-- vim.cmd [[ vnoremap <silent> <Find-Shortcut>  :Farf<cr> ]]

	-- -- shortcut for far.vim replace
	-- vim.cmd [[ nnoremap <silent> <Replace-Shortcut>  :Farr<cr> ]]
	-- vim.cmd [[ vnoremap <silent> <Replace-Shortcut>  :Farr<cr> ]]

	-- shortcut for far.vim find
	vim.api.nvim_set_keymap("n", "<Find-Shortcut>", ":Farf<cr>", { silent = true, noremap = true })
	vim.api.nvim_set_keymap("v", "<Find-Shortcut>", ":Farf<cr>", { silent = true, noremap = true })
	-- shortcut for far.vim replace
	vim.api.nvim_set_keymap("n", "<Replace-Shortcut", ":Farr<cr>", { silent = true, noremap = true })
	vim.api.nvim_set_keymap("v", "<Replace-Shortcut", ":Farr<cr>", { silent = true, noremap = true })
end

function config.vim_visual_multi()
	vim.g.VM_show_warnings = 0
	vim.g.VM_leader = "\\"
	vim.g.VM_maps = {
		Undo = "u",
		Redo = "<C-r>",
		["Add Cursor Down"] = "<M-j>", -- 往下增加光标 Opt+j
		["Add Cursor Up"] = "<M-k>", -- 往上增加光标 Opt+k
		-- ["Select All"] = '\\A',
	}

	-- Opt+h Opt+l 在多光标模式下 可以移动单个光标 而不是所有光标
	vim.api.nvim_set_keymap("n", "<M-h>", "<Left>", {})
	vim.api.nvim_set_keymap("n", "<M-l>", "<Right>", {})
end

function config.hop_nvim()
	require("hop").setup({
		keys = ";sftunq/SFGHLTUNRMQZ?0123456789",
	})

	-- https://github.com/phaazon/hop.nvim#keybindings
	-- place this in one of your configuration file(s)
	vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false })<cr>", {})
	vim.api.nvim_set_keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false })<cr>", {})
	vim.api.nvim_set_keymap('v', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false })<cr>", {})
	vim.api.nvim_set_keymap('v', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false })<cr>", {})
end

function config.symbols_outline()
	require("symbols-outline").setup({
		highlight_hovered_item = true,
		auto_close = false,
		auto_preview = false,
		relative_width = true,
		show_symbol_details = true,
		width = 25,
		keymaps = { -- These keymaps can be a string or a table for multiple keys
			close = { "<Esc>", "q" },
			goto_location = "<Cr>",
			focus_location = "o",
			hover_symbol = "<C-space>",
			toggle_preview = "K",
			rename_symbol = "r",
			code_actions = "a",
		},
	})
	vim.api.nvim_set_keymap("n", "<Space>o", ":SymbolsOutline<CR>", { noremap = true, silent = true })
	vim.cmd [[ hi FocusedSymbol gui=bold guifg=#C678DD ]]

	-- https://github.com/simrat39/symbols-outline.nvim/issues/93#issuecomment-1003566569
	_G.set_symbols_outline_state = function()
		vim.g["symbols_outline_state"] = require("symbols-outline").state
	end
	vim.cmd [[ autocmd BufEnter * :lua set_symbols_outline_state() ]]
	vim.cmd [[ autocmd BufEnter * if winnr("$") == 1 && exists("g:symbols_outline_state.outline_buf") && g:symbols_outline_state.outline_buf | quit | endif ]]
end

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

return config
