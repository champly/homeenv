local cache_dir               = os.getenv("HOME") .. "/.cache/nvim/"

vim.g.color_theme_dark        = "dark"
vim.g.color_theme_light       = "light"
vim.g.color_theme             = vim.g.color_theme_light -- dark or light if you want light mode
vim.g.go_import_without_local = true

-- for neovide
-- https://neovide.dev/configuration.html
vim.o.guifont                 = "SauceCodePro Nerd Font"
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_fullscreen      = "v:false"
vim.g.neovide_transparency    = 1
-- vim.g.transparency = 0.6

vim.opt.encoding              = "utf-8" -- scriptencoding utf-8
vim.opt.termguicolors         = true
vim.opt.relativenumber        = true    -- 显示相对行号
vim.opt.foldmethod            = "expr"  -- 设置折叠语法
vim.o.foldexpr                = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevelstart        = 99      -- 默认不折叠
vim.opt.backup                = false
vim.opt.writebackup           = false
vim.opt.swapfile              = false
vim.opt.undodir               = cache_dir .. "undo"
vim.opt.undofile              = true
vim.opt.mouse                 = "v"
vim.opt.scrolloff             = 1    -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.tabstop               = 4    -- An indentation every four columns
vim.opt.shiftwidth            = 4
vim.opt.softtabstop           = 4    -- Let backspace delete indent
vim.opt.autoindent            = true
vim.opt.splitright            = true -- Puts new vsplit windows to the right of the current
vim.opt.splitbelow            = true -- Puts new split windows to the bottom of the current
vim.opt.smartindent           = true -- Open smart indent
-- 忽略大小写
vim.opt.ignorecase            = true
vim.opt.smartcase             = true
-- 设置光标所在行、列高亮
-- vim.opt.cursorcolumn      = true
vim.opt.cursorline            = true
vim.opt.hlsearch              = true
-- hit-enter
vim.opt.cmdheight             = 0
-- 区分空格和缩进
vim.opt.list                  = true
vim.opt.showbreak             = "↪ "
-- vim.opt.listchars             = "tab:▸ ,space:⋅,trail:·,precedes:←,extends:→" -- 复制的时候会空格会一起复制出去
vim.opt.listchars             = "tab:▸ ,trail:·,precedes:←,extends:→"
-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime            = 300
-- 0: never
-- 1: only if there are at least two windows
-- 2: always
-- 3: always and ONLY the last window
vim.opt.laststatus            = 3
-- vim.opt.textwidth = 120 -- 设置自动加上换行符的长度
vim.opt.colorcolumn           = "120"
vim.opt.number                = true  -- 默认显示数字栏
vim.opt.expandtab             = false -- 选项把插入的 tab 字符替换成特定数目的空格

vim.o.timeoutlen              = 300   --毫秒计的等待映射的键序列完成的时间
vim.o.maxmempattern           = 5000  -- maxmempattern规定了vim做字符串匹配时使用的最大内存，不是由每行字符数决定的。
vim.o.conceallevel            = 2

---@diagnostic disable-next-line: undefined-field
if vim.uv.os_uname().sysname == "Darwin" then
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
	---@diagnostic disable-next-line: undefined-field
	if not vim.uv.fs_stat("/usr/local/bin/python3") then
		vim.g.python3_host_prog = "/usr/bin/python3"
	else
		vim.g.python3_host_prog = "/usr/local/bin/python3"
	end
end
