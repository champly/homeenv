local vim = vim
local tool = require("utils.tool")
local autocmd = {}

function autocmd.load_autocmds()
	local definitions = {
		-- packer = {},
		bufs = {
			-- 文件打开的时候光标停留在上次关闭时候的位置
			{"BufReadPost", "*", [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]},
			-- https://github.com/kyazdani42/nvim-tree.lua#tips--reminders
			{"BufEnter", "*", [[++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]]},
		},
		wins = {
			-- Don't show status line on certain windows
			{"BufEnter,BufRead,BufWinEnter,FileType,WinEnter", "*", "lua require('core.define').hide_statusline()"}
		},
		ft = {
			-- https://github.com/mhinz/vim-grepper/issues/117
			{"FileType", "qf", "if mapcheck('<esc>', 'n') ==# '' | nnoremap <buffer><silent> <esc> :cclose<bar>lclose<cr> | endif"};
			-- 在Vim中更改quickfix窗口的默认位置 窗口到最下方
			-- https://stackoverflow.com/questions/6726783/changing-default-position-of-quickfix-window-in-vim
			-- 目前的问题是 偶尔需要手动执行 MiniBufExplorer
			{"FileType", "qf", "wincmd J"};
		},
		-- yank = {},
	}

	tool.nvim_create_augroups(definitions)
end

autocmd.load_autocmds()
