local config = {}

function config.nvim_treesitter()
	vim.api.nvim_command('set foldmethod=expr')
	vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')

	require("nvim-treesitter.configs").setup {
		ensure_installed = "maintained",
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

function config.undotree()
	-- nnoremap <Leader>u :UndotreeToggle<CR>
	vim.api.nvim_set_keymap("n", "<leader>u", ":UndotreeToggle<cr>", { noremap = true })
	-- If set to 1, the undotree window will get focus after being opened, otherwise focus will stay in current window.
	vim.g.undotree_SetFocusWhenToggle = 1

	-- local bind = require("utils.bind")
	-- bind.nvim_load_mapping({
	--     ["n|<leader>u"] = bind.map_cr("UndotreeToggle"):with_noremap(),
	-- })
end

function config.vimwiki()
	vim.g.vimwiki_list = {
		{
			path = '~/Dropbox/notebook/vimwiki/',
			syntax = 'markdown',
			ext = '.md'
		}
	}
end

function config.far_vim()
	vim.cmd [[ set lazyredraw ]]            -- improve scrolling performance when navigating through large results
	vim.cmd [[ set regexpengine=1 ]]        -- use old regexp engine
	vim.cmd [[ set ignorecase smartcase ]]  -- ignore case only when the pattern contains no capital letters

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
	vim.g.VM_leader = '\\'
	vim.g.VM_maps = {
		Undo = "u",
		Redo = "<C-r>",
		["Add Cursor Down"] = '<M-j>',	   -- 往下增加光标 Opt+j
		["Add Cursor Up"] = '<M-k>',	   -- 往上增加光标 Opt+k
		-- ["Select All"] = '\\A',
	}

	-- Opt+h Opt+l 在多光标模式下 可以移动单个光标 而不是所有光标
	vim.api.nvim_set_keymap("n", "<M-h>", "<Left>", {})
	vim.api.nvim_set_keymap("n", "<M-l>", "<Right>", {})
end

function config.vim_sneak()
	-- https://tc500.github.io/%E5%B7%A5%E5%85%B7%E9%93%BE/2019/02/08/%E9%AB%98%E6%95%88%E7%9A%84vim/
	vim.g.sneak = {
		label = 1, 	-- 开启跳转标签
		target_labels = ";sftunq/SFGHLTUNRMQZ?0123456789", -- 标签字符序列
	}
	-- f正向查找字符，F反向查找字符
	-- vim.cmd [[ nnoremap <silent> f :<C-U>call sneak#wrap('',           1, 0, 1, 1)<CR> ]]
	-- vim.cmd [[ nnoremap <silent> F :<C-U>call sneak#wrap('',           1, 1, 1, 1)<CR> ]]
	-- vim.cmd [[ xnoremap <silent> f :<C-U>call sneak#wrap(visualmode(), 1, 0, 1, 1)<CR> ]]
	-- vim.cmd [[ xnoremap <silent> F :<C-U>call sneak#wrap(visualmode(), 1, 1, 1, 1)<CR> ]]
	-- vim.cmd [[ onoremap <silent> f :<C-U>call sneak#wrap(v:operator,   1, 0, 1, 1)<CR> ]]
	-- vim.cmd [[ onoremap <silent> F :<C-U>call sneak#wrap(v:operator,   1, 1, 1, 1)<CR> ]]
	vim.api.nvim_set_keymap("n", "f", ":<C-U>call sneak#wrap('',           1, 0, 1, 1)<CR>", { silent = true, noremap = true })
	vim.api.nvim_set_keymap("n", "F", ":<C-U>call sneak#wrap('',           1, 0, 1, 1)<CR>", { silent = true, noremap = true })
	vim.api.nvim_set_keymap("x", "f", ":<C-U>call sneak#wrap(visualmode(), 1, 0, 1, 1)<CR>", { silent = true, noremap = true })
	vim.api.nvim_set_keymap("x", "F", ":<C-U>call sneak#wrap(visualmode(), 1, 0, 1, 1)<CR>", { silent = true, noremap = true })
	vim.api.nvim_set_keymap("o", "f", ":<C-U>call sneak#wrap(v:operator,   1, 0, 1, 1)<CR>", { silent = true, noremap = true })
	vim.api.nvim_set_keymap("o", "F", ":<C-U>call sneak#wrap(v:operator,   1, 0, 1, 1)<CR>", { silent = true, noremap = true })
end

return config
