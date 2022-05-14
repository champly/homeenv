" 使用浏览器打开光标下的链接
" https://github.com/vim/vim/issues/4738#issuecomment-714609892
if has('macunix')
	function! OpenURLUnderCursor()
		let s:uri = matchstr(getline('.'), '[a-z]*:\/\/[^ >,;()]*')
		let s:uri = shellescape(s:uri, 1)
		if s:uri != ''
			silent exec "!open '".s:uri."'"
			:redraw!
		endif
	endfunction
	nnoremap gx :call OpenURLUnderCursor()<CR>
else
	" https://qastack.cn/vi/2801/how-can-i-make-gx-recognise-full-urls-in-vim
	let g:netrw_browsex_viewer = 'google-chrome'
endif

" " ===
" " " === grepper
" " " ===
" if isdirectory(expand(modules_path .. "vim-grepper"))
"     " 先加载了`g:grepper`才有值
"     runtime plugin/grepper.vim

"     let g:grepper.highlight = 1		" 高亮显示搜索内容
"     let g:grepper.stop = 1000		" 查找到多少个后就停止搜索
"     let g:grepper.switch = 0		" 自动切换到quickfix窗口

"     " Search for the current word
"     nnoremap <leader>* :Grepper -tool ag -cword -noprompt<CR>

"     vnoremap <F4> <Esc>:<C-u>Rg -wS '<C-r>=GetVisual('rg')<CR>'  <C-h>
"     nnoremap <expr> <F4> ":Rg -wS " . expand('<cword>') . ' '

"     " Get the current visual block for search and replaces
"     " This function passed the visual block through a string escape function
"     " Based on this - https://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
"     function! GetVisual(tool) range
"         " Save the current register and clipboard
"         let reg_save = getreg('"')
"         let regtype_save = getregtype('"')
"         let cb_save = &clipboard
"         set clipboard&

"         " Put the current visual selection in the " register
"         normal! ""gvy
"         let selection = getreg('"')

"         " Put the saved registers and clipboards back
"         call setreg('"', reg_save, regtype_save)
"         let &clipboard = cb_save

"         "Escape any special characters in the selection
"         let l:escaped_selection = EscapeString(selection, a:tool)

"         " 删除行尾换行符
"         if strlen(l:escaped_selection) > 2 && l:escaped_selection[-2:] == '\n'
"             let l:escaped_selection = l:escaped_selection[:-3]
"         endif

"         return l:escaped_selection
"     endfunction
" endif



" ===
" === Functions
" ===
" 循环设置鼠标
let g:set_mouse_value = &mouse	" 获取当前的mouse值 :set mouse?
function! CycleMouseValue()
	if g:set_mouse_value == 'a'
		let g:set_mouse_value = 'v'
		echo 'set mouse=v'
	elseif g:set_mouse_value == 'v'
		let g:set_mouse_value = 'a'
		echo 'set mouse=a'
	endif
	execute 'set mouse='.g:set_mouse_value
endfunction
nnoremap <silent> <leader>sm :call CycleMouseValue()<CR>

" quickfix 窗口开关快捷键
function! QuickfixToggle()
	" FROM: https://www.reddit.com/r/vim/comments/5ulthc/how_would_i_detect_whether_quickfix_window_is_open/
	if filter(getwininfo(), 'v:val.quickfix && !v:val.loclist') != []
		cclose
	else
		copen
	endif
	" call RedrawMiniBufExplorer()
endfunction
nnoremap <silent> <leader>q :call QuickfixToggle()<CR>

" quickfix 是最后一个窗口的时候自动关闭
aug QFClose
	au!
	au WinEnter *  if winnr('$') == 1 && &buftype == "quickfix"|q|endif
aug END



" ===
" === General
" ===
" quick open vimrc in a new tab
" nnoremap <leader>v	:e $MYVIMRC<cr>
" nnoremap <leader>s	:source $MYVIMRC<cr>

" " hidden not save buffer, repeat with coc.nvim
" set hidden

" 开启新的无名缓冲区
nnoremap <leader>n  :enew<CR>
nnoremap <leader>bd :bd!<CR>

" 毫秒计的等待映射的键序列完成的时间
set timeoutlen=300

" [Vim 中正确使用 Alt 映射](http://www.skywind.me/blog/archives/1846)
function! Terminal_MetaMode(mode)
	set ttimeout
	if $TMUX != ''
		set ttimeoutlen=30
	elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
		set ttimeoutlen=80
	endif
	if has('nvim') || has('gui_running')
		return
	endif
	function! s:metacode(mode, key)
		if a:mode == 0
			exec "set <M-".a:key.">=\e".a:key
		else
			exec "set <M-".a:key.">=\e]{0}".a:key."~"
		endif
	endfunc
	for i in range(10)
		call s:metacode(a:mode, nr2char(char2nr('0') + i))
	endfor
	for i in range(26)
		call s:metacode(a:mode, nr2char(char2nr('a') + i))
		call s:metacode(a:mode, nr2char(char2nr('A') + i))
	endfor
	if a:mode != 0
		for c in [',', '.', '/', ';', '[', ']', '{', '}']
			call s:metacode(a:mode, c)
		endfor
		for c in ['?', ':', '-', '_']
			call s:metacode(a:mode, c)
		endfor
	else
		for c in [',', '.', '/', ';', '{', '}']
			call s:metacode(a:mode, c)
		endfor
		for c in ['?', ':', '-', '_']
			call s:metacode(a:mode, c)
		endfor
	endif
endfunc
command! -nargs=0 -bang VimMetaInit call Terminal_MetaMode(<bang>0)

function! Terminal_MetaMode_LQ(mode)
	if has('nvim') || has('gui_running')
		return
	endif
	function! s:metacode(mode, key)
		if a:mode == 0
			exec "set <M-".a:key.">=\e".a:key
		else
			exec "set <M-".a:key.">=\e]{0}".a:key."~"
		endif
	endfunc
	for c in ['h', 'j', 'k', 'l', 'o', 'L']
		call s:metacode(a:mode, c)
	endfor
	if &ttimeout == 0
		set ttimeout
	endif
	if $TMUX != ''
		set ttimeoutlen=30
	elseif &ttimeoutlen <= 0
		set ttimeoutlen=50
	endif
endfunc
" 非0: 定义为更不容易混淆的：<ESC>]{0}x~ 格式（但是需要设置终端软件里每个ALT-x 组合键发送什么）
" 0: 定义为：<ESC>x 格式 但是需要配合ttimeoutlen使用 否则会误触发
call Terminal_MetaMode_LQ(1)

" https://zhuanlan.zhihu.com/p/20902166
" 在当前位置打开文件浏览器
" Open Explore in new tab with current directory
function! Open_Explore(where)
	let l:path = expand("%:p:h")
	if l:path == ''
		let l:path = getcwd()
	endif
	if a:where == 0
		exec 'Explore '.fnameescape(l:path)
	elseif a:where == 1
		exec 'vnew'
		exec 'Explore '.fnameescape(l:path)
	else
		exec 'tabnew'
		exec 'Explore '.fnameescape(l:path)
	endif
endfunc
" 在新tab中打开某个文件
noremap <silent> <M-o> :call Open_Explore(2)<CR>

" 重绘屏幕，当使用 Command+K 误清空屏幕之后可以使用
noremap <silent> <M-L> :redraw!<CR>

" maxmempattern规定了vim做字符串匹配时使用的最大内存，不是由每行字符数决定的。
" 默认配置是1000 set maxmempattern?
set maxmempattern=5000



" ===
" === Markdown Settings
" ===
" Snippets
source ~/.config/nvim/ultisnips/md-snippets.vim
" auto spell
autocmd BufRead,BufNewFile *.md setlocal spell



" ===
" === Finial
" ===
" command line mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>

" 强制写入
cnoremap w!! w !sudo tee % >/dev/null

" 使用 leader+w 在插入和normal模式下保存文件，我经常在 insert 模式下代替 Esc
" inoremap <silent> <leader>w  <Esc>:wa<CR>
" noremap	 <silent> <leader>w  :wa<CR>
" inoremap <leader>wq <Esc>:wq<CR>
" noremap  <leader>wq :wq<CR>
" 导致关闭quickfix leader q 延迟
" noremap  <leader>qq :q!<CR>

" 分屏
noremap sh :set splitright<CR>:vs<CR>
noremap sl :set nosplitright<CR>:vs<CR>
noremap sk :set splitbelow<CR>:sp<CR>
noremap sj :set nosplitbelow<CR>:sp<CR>
" noremap H :vertical resize-5<CR>
" noremap L :vertical resize+5<CR>
" noremap J :res +5<CR>
" noremap K :res -5<CR>
noremap ss <C-w>t<C-w>H
noremap sp <C-w>t<c-w>K

" Tab
noremap <leader>tu :tabe<CR>
noremap <leader>tn :-tabnext<CR>
noremap <leader>tp :+tabnext<CR>

" Press space twice to jump to the next '<++>' and edit it
noremap <leader><leader>  <Esc>/<++><CR>:nohlsearch<CR>c4l
inoremap <leader><leader> <Esc>/<++><CR>:nohlsearch<CR>c4l

" https://github.com/neoclide/coc.nvim/issues/1281#issuecomment-718234037
" https://github.com/neoclide/coc.nvim/issues/1160
" nnoremap <C-m> <C-w><C-p>

" 插入模式下移动光标位置
inoremap <C-h> <left>
inoremap <C-j> <C-o>gj
inoremap <C-k> <C-o>gk
inoremap <C-l> <Right>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-b> <Left>
inoremap <C-f> <Right>

" 移动光标所在的窗口
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l

" 停止搜索高亮的键映射
nnoremap <silent> <F2>		:nohlsearch<CR>
inoremap <silent> <F2> <C-O>:nohlsearch<CR>

" cheat-sheet
" https://www.nerdfonts.com/cheat-sheet
