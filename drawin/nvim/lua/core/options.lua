local global = require("core.global")

local function bind_option(options)
	for k, v in pairs(options) do
		if v == true or v == false then
			vim.cmd("set " .. k)
		else
			vim.cmd("set " .. k .. "=" .. v)
		end
	end
end

local function load_options()
	local global_local = {
		encoding       = "utf-8"; -- scriptencoding utf-8
		termguicolors  = true;
		relativenumber = true; -- 显示相对行号
		foldmethod     = "syntax"; -- 设置折叠语法
		foldlevelstart = 99; -- 默认不折叠
		undodir        = global.cache_dir .. "undo";
		undofile       = true;
		mouse          = "v";
		scrolloff      = 1; -- Minimal number of screen lines to keep above and below the cursor.
		tabstop        = 4; -- An indentation every four columns
		shiftwidth     = 4;
		softtabstop    = 4; -- Let backspace delete indent
		autoindent     = true;
		splitright     = true; -- Puts new vsplit windows to the right of the current
		splitbelow     = true; -- Puts new split windows to the bottom of the current
		smartindent    = true; -- Open smart indent

		-- 忽略大小写
		ignorecase = true;
		smartcase  = true;

		-- 设置光标所在行、列高亮
		-- cursorcolumn      = true;
		cursorline = true;
		hlsearch   = true;

		-- hit-enter
		cmdheight = 1;

		-- 区分空格和缩进
		list = true;
		showbreak = "↪ ";
		listchars = "tab:▸ ,trail:·,precedes:←,extends:→";

		-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
		-- delays and poor user experience.
		updatetime = 300;

		-- 2总显示最后一个窗口的状态行，1窗口多于一个时显示最后一个窗口的状态行，0不显示最后一个窗口的状态行
		laststatus = 2;
	}

	local bw_local = {
		-- textwidth = 120; -- 设置自动加上换行符的长度
		colorcolumn = 120;
		number = true; -- 默认显示数字栏
		nobackup = true; -- 不需要备份文件，保留撤销文件
		noexpandtab = true;
	}

	if global.is_mac then
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

	for name, value in pairs(global_local) do
		vim.o[name] = value
	end
	bind_option(bw_local)
end

return load_options()
