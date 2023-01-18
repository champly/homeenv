local opt = vim.opt
local cache_dir = os.getenv("HOME") .. "/.cache/nvim/"

opt.encoding       = "utf-8" -- scriptencoding utf-8
opt.termguicolors  = true
opt.relativenumber = true -- 显示相对行号
opt.foldmethod     = "syntax" -- 设置折叠语法
opt.foldlevelstart = 99 -- 默认不折叠
opt.backup         = false
opt.writebackup    = false
opt.swapfile       = false
opt.undodir        = cache_dir .. "undo"
opt.undofile       = true
opt.mouse          = "v"
opt.scrolloff      = 1 -- Minimal number of screen lines to keep above and below the cursor.
opt.tabstop        = 4 -- An indentation every four columns
opt.shiftwidth     = 4
opt.softtabstop    = 4 -- Let backspace delete indent
opt.autoindent     = true
opt.splitright     = true -- Puts new vsplit windows to the right of the current
opt.splitbelow     = true -- Puts new split windows to the bottom of the current
opt.smartindent    = true -- Open smart indent
-- 忽略大小写
opt.ignorecase     = true
opt.smartcase      = true
-- 设置光标所在行、列高亮
-- opt.cursorcolumn      = true
opt.cursorline     = true
opt.hlsearch       = true
-- hit-enter
opt.cmdheight      = 0
-- 区分空格和缩进
opt.list           = true
opt.showbreak      = "↪ "
opt.listchars      = "tab:▸ ,trail:·,precedes:←,extends:→"
-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
opt.updatetime     = 300
-- 0: never
-- 1: only if there are at least two windows
-- 2: always
-- 3: always and ONLY the last window
opt.laststatus     = 3
-- opt.textwidth = 120 -- 设置自动加上换行符的长度
opt.colorcolumn    = "120"
opt.number         = true -- 默认显示数字栏
opt.expandtab      = false -- 选项把插入的 tab 字符替换成特定数目的空格

if vim.loop.os_uname().sysname == "Darwin" then
	vim.g.clipboard = {
		name = "macOS-clipboard",
		copy = {
			["+"] = "pbcopy",
			["*"] = "pbcopy",
		},
		paste = {
			["+"] = "pbpaste",
			["*"] = "pbpaste",
		},
		cache_enabled = 0
	}

	-- https://zhuanlan.zhihu.com/p/24484514
	vim.g.python3_host_skip_check = 1
	if not vim.loop.fs_stat("/usr/local/bin/python3") then
		vim.g.python3_host_prog = "/usr/bin/python3"
	else
		vim.g.python3_host_prog = "/usr/local/bin/python3"
	end
end
