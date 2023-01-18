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



" ===
" === Markdown Settings
" ===
" Snippets
source ~/.config/nvim/ultisnips/md-snippets.vim
" auto spell
autocmd BufRead,BufNewFile *.md setlocal spell
