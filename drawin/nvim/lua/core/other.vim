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



" " hidden not save buffer, repeat with coc.nvim
" set hidden

" 毫秒计的等待映射的键序列完成的时间
set timeoutlen=300

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
