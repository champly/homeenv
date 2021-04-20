" FROM: https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
" Install vim-plug if not found
if has("nvim")
	if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
		silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
else
	if empty(glob('~/.vim/autoload/plug.vim'))
		silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
endif

" Specify a directory for plugins
call plug#begin('~/.vim/bundle')

" Make sure you use single quotes

" " file system explorer
" Plug 'preservim/nerdtree'
" Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'ryanoasis/vim-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'kyazdani42/nvim-web-devicons'

" go language support
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" neovim 0.5 > lsp
" Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-lua/completion-nvim'

" Debugger
" Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-go'}

" code-completion engine
" Plug 'Valloric/YouCompleteMe'
Plug 'neoclide/coc.nvim' , {'branch': 'release'}

" asynchronous lint engine
" Plug 'dense-analysis/ale'

" annotate plugin: https://github.com/preservim/nerdcommenter#settings
Plug 'preservim/nerdcommenter'

" class outline viewer
Plug 'majutsushi/tagbar'
" Plug 'liuchengxu/vista.vim'

" parentheses improved
Plug 'luochen1990/rainbow'

" fzf
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Insert or delete brackets, parens, quotes in pair
Plug 'jiangmiao/auto-pairs'

" Lean & mean status/tabline for vim that's light as air.
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}

" theme
" Plug 'tomasiser/vim-code-dark'
Plug 'morhetz/gruvbox'
" Plug 'rakr/vim-one'

" choice multi line
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'terryma/vim-multiple-cursors'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" tpope plug
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
" https://gist.github.com/wilon/ac1fc66f4a79e7b0c161c80877c75c94
Plug 'tpope/vim-surround'
Plug 'gcmt/wildfire.vim'

" The plug-in visualizes undo history and makes it easier to browse and switch between different undo branches
Plug 'mbbill/undotree'

" Jump to any location specified by two characters.
Plug 'justinmk/vim-sneak'

" snipets
" will modify tab map, so forbide
" Plug 'SirVer/ultisnips'

" VimWiki is a personal wiki for Vim
Plug 'vimwiki/vimwiki'

" syntax highlighting, matching rules and mapping for the original Markdown and extensions
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'dhruvasagar/vim-table-mode'

" quick find word
Plug 'mhinz/vim-grepper'
Plug 'brooth/far.vim'

" float terminal
Plug 'voldikss/vim-floaterm'

" This plugin provides a start screen
" Plug 'mhinz/vim-startify'
Plug 'glepnir/dashboard-nvim'

" debug
Plug 'tweekmonster/startuptime.vim'

" Initialize plugin system
call plug#end()

" map the <Leader> key as ",",the default is "\"
let mapleader = ","



" ===
" === Formatting
" ===
" scriptencoding utf-8
set encoding=utf-8

" source $VIMRUNTIME/vimrc_example.vim

set textwidth=120		" 设置自动加上换行符的长度
set relativenumber		" 显示相对行号
set number				" 默认显示数字栏
set nobackup			" 不需要备份文件，保留撤销文件
" set foldmethod=indent
" set nowritebackup		" 编辑的时候不需要备份文件
" set noswapfile		" 表示不创建临时交换文件

if has('persistent_undo')
	set undofile
	set undodir=~/.vim/undodir
	if !isdirectory(&undodir)
		call mkdir(&undodir, 'p', 0700)
	endif
endif

" if has('mouse')
"	  if has('gui_running') || (&term =~ 'xterm' && !has('mac'))
"		  set mouse=a
"	  else
"		  set mouse=nvi
"	  endif
" endif
set mouse=v

set scrolloff=1					" Minimal number of screen lines to keep above and below the cursor.
set tabstop=4					" An indentation every four columns
set shiftwidth=4
set softtabstop=4				" Let backspace delete indent
set autoindent
set splitright					" Puts new vsplit windows to the right of the current
set splitbelow					" Puts new split windows to the bottom of the current
set smartindent					" Open smart indent

" 忽略大小写
set ignorecase
set smartcase

set noexpandtab

" " 区分空格和缩进
set list
set showbreak=↪\ 
" set listchars=tab:\|\ ,trail:▫
set listchars=tab:▸\ ,trail:·,precedes:←,extends:→

" " 设置json双引号显示
" let g:vim_json_syntax_conceal = 0

" 在Vim中更改quickfix窗口的默认位置 窗口到最下方
" https://stackoverflow.com/questions/6726783/changing-default-position-of-quickfix-window-in-vim
" 目前的问题是 偶尔需要手动执行 MiniBufExplorer
autocmd! FileType qf wincmd J

" https://github.com/mhinz/vim-grepper/issues/117
augroup vimrcQfClose
	autocmd!
	autocmd FileType qf if mapcheck('<esc>', 'n') ==# '' | nnoremap <buffer><silent> <esc> :cclose<bar>lclose<CR> | endif
augroup END

" 文件打开的时候光标停留在上次关闭时候的位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" Call figlet
" brew install figlet
noremap tx :r !figlet

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
" === UI
" ===
if has('gui_running')
	set guifont='SourceCodeProForPowerline-Regular:h13'
	set guifontwide='SourceCodeProForPowerline-Regular:h13'
endif

" ctermfg => :help cterm-colors
" https://github.com/eikenb/terminal-colors look at all color
" hi Search term=standout ctermfg=0 ctermbg=3
" if has('termguicolors') && ($COLORTERM == 'truecolor' || $COLORTERM == '24bit')
"     set termguicolors
" endif
set termguicolors
set colorcolumn=120

" 背景透明 没生效
" highlight Normal ctermbg=None

" if isdirectory(expand("~/.vim/bundle/vim-code-dark"))
"     colorscheme codedark
"     let g:airline_theme = 'codedark'
"     hi Search guibg=#d78700 guifg=#ffd700
"     hi CursorLine guibg=#383838 guifg=NONE
" endif

if isdirectory(expand("~/.vim/bundle/gruvbox"))
	let g:gruvbox_italic = 1
	colorscheme gruvbox
	set background=dark
	" hi Search guibg=NONE guifg=#ff8600
	" hi CursorLine guibg=#ffffaf guifg=NONE
	" let g:airline_theme = 'gruvbox'
endif

" if isdirectory(expand("~/.vim/bundle/vim-one"))
"     set background=light		" for the light version
"     let g:one_allow_italics = 1 " I love italic for comments
"     hi Search guibg=#5fff00 guifg=#ff8700
"     hi CursorLine guibg=#ffffaf guifg=NONE
"     colorscheme one
"     let g:airline_theme='one'
" endif

" 设置光标所在行、列高亮
" set cursorcolumn
set cursorline

set hlsearch



" ===
" === nvim-treesitter
" ===
if isdirectory(expand("~/.vim/bundle/nvim-treesitter"))
	lua require("modules.lang.plugins")
end



" ===
" === nvim-lspconfig
" ===
if isdirectory(expand("~/.vim/bundle/nvim-lspconfig"))
	lua require("modules.completion.plugins")
endif



" " ===
" " === vim-go
" " ===
" if isdirectory(expand("~/.vim/bundle/vim-go"))
"     " augroup _vim_go_
"     "     " https://github.com/fatih/vim-go/blob/bd56f5690807d4a92652fe7a4d10dc08f260564e/doc/vim-go.txt#L938
"     "     " example:	 au FileType go nnoremap <leader>r <Plug>(go-run)

"     "     au FileType go nnoremap <leader>im <Plug>(go-implements)
"     "     au FileType go nnoremap <leader>rf <Plug>(go-referrers)
"     "     au FileType go nnoremap <leader>if <Plug>(go-info)
"     "     " au FileType go nnoremap <Leader>rn <Plug>(go-rename)
"     "     au FileType go nnoremap <leader>ds <Plug>(go-def-split)
"     "     au FileType go nnoremap <leader>dv <Plug>(go-def-vertical)
"     "     au FileType go nnoremap <leader>dt <Plug>(go-def-tab)
"     " augroup END

"     " https://github.com/golang/tools/blob/master/gopls/doc/vim.md#vim-go
"     " let g:go_implements_mode = 'gopls'
"     " let g:go_def_mode='gopls'
"     " let g:go_info_mode='gopls'

"     " https://github.com/fatih/vim-go/blob/bd56f5690807d4a92652fe7a4d10dc08f260564e/doc/vim-go.txt#L2589
"     " let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
"     " let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

"     " let g:go_fmt_command = "goimports"

"     " highlight
"     let g:go_highlight_array_whitespace_error = 1
"     let g:go_highlight_chan_whitespace_error = 1
"     let g:go_highlight_extra_types = 1
"     let g:go_highlight_space_tab_error = 1
"     let g:go_highlight_trailing_whitespace_error = 1
"     let g:go_highlight_operators = 1
"     let g:go_highlight_functions = 1
"     let g:go_highlight_function_parameters = 1
"     let g:go_highlight_function_calls = 1
"     let g:go_highlight_types = 1
"     let g:go_highlight_fields = 1
"     let g:go_highlight_build_constraints = 1
"     let g:go_highlight_generate_tags = 1
"     let g:go_highlight_string_spellcheck = 1
"     let g:go_highlight_format_strings = 1
"     let g:go_highlight_variable_declarations = 0
"     let g:go_highlight_variable_assignments = 0
"     let g:go_highlight_diagnostic_errors = 1
"     let g:go_highlight_diagnostic_warnings = 1

"     " let g:go_auto_sameids = 1			" Use this option to highlight all uses of the identifier under the cursor
"     let g:go_list_type = "quickfix"		" do not pop up location lists
"     let g:go_list_height = 10			" the height of quickfix and locationlist

"     " " 切换是否自动显示单词引用
"     " nnoremap <silent> <F3>	  :GoSameIdsAutoToggle<CR>
"     " inoremap <silent> <F3> <C-O>:GoSameIdsAutoToggle<CR>

"     " https://github.com/fatih/vim-go/issues/1271
"     " wrap long lines in quickfix
"     augroup quickfix
"         autocmd!
"         autocmd FileType qf setlocal wrap
"     augroup END

"     " 减少启动 gopls 的个数
"     let g:go_gopls_options = ['-remote=auto']

"     " https://github.com/josa42/coc-go/issues/105
"     let g:go_gopls_enabled = 0
"     let g:go_def_mapping_enabled = 0
" endif



" ===
" === YouCompleteMe
" ===
" if isdirectory(expand("~/.vim/bundle/YouCompleteMe"))
	" " https://github.com/ycm-core/YouCompleteMe/issues/2015#issuecomment-189917191
	" set completeopt-=preview

	" " 长期停留不自动文档提示
	" let g:ycm_auto_hover = ''
	" " 写注释的时候也能自动提示
	" let g:ycm_complete_in_comments = 1
	" " 只在下面的文件列表里面提示
	" let g:ycm_filetype_whitelist = {
		" \ 'go': 1,
		" \ 'c': 1,
		" \ 'cpp': 1,
		" \ 'python': 1,
		" \ 'vim': 1,
		" \ 'sh': 1,
		" \ 'zsh': 1,
		" \ }
	" " 当跳转的文件没有打开的时候分隔窗口的方式打开
	" let g:ycm_goto_buffer_command = 'split-or-existing-window'
	" " 提示键映射
	" " let g:ycm_key_invoke_completion = '<C-Z>'
" endif



" ===
" === coc.nvim
" ===
if isdirectory(expand("~/.vim/bundle/coc.nvim"))
	let g:coc_global_extensions = [
				\ "coc-json",
				\ "coc-vimlsp",
				\ "coc-marketplace",
				\ "coc-explorer",
				\ "coc-actions",
				\ "coc-gitignore",
				\ "coc-prettier",
				\ "coc-yaml",
				\ "coc-translator",
				\ "coc-syntax",
				\ "coc-git",
				\ "coc-yaml",
				\ "coc-rls",
				\ "coc-lua",
			\ ]
	" https://github.com/neoclide/coc.nvim/issues/1789#issuecomment-616133267
	let g:node_client_debug = 1

	" coc-explorer
	" https://github.com/npm/npm/issues/9401#issuecomment-134569585

	" TextEdit might fail if hidden is not set.
	set hidden

	" " Some servers have issues with backup files, see #649.
	" set nobackup
	" set nowritebackup

	" " Give more space for displaying messages.
	" set cmdheight=2

	" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
	" delays and poor user experience.
	set updatetime=300
	" Don't pass messages to |ins-completion-menu|.
	set shortmess+=c

	" " Always show the signcolumn, otherwise it would shift the text each time
	" " diagnostics appear/become resolved.
	if has("patch-8.1.1564")
		" Recently vim can merge signcolumn and number column into one
		set signcolumn=number
	else
		set signcolumn=yes
	endif

	" Use tab for trigger completion with characters ahead and navigate.
	" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
	" other plugin before putting this into your config.
	inoremap <silent><expr> <TAB>
		\ pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<TAB>" :
		\ coc#refresh()
	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

	function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]	=~# '\s'
	endfunction

	" Use <c-space> to trigger completion.
	if has('nvim')
		inoremap <silent><expr> <c-o> coc#refresh()
	else
		inoremap <silent><expr> <c-@> coc#refresh()
	endif

	" Make <CR> auto-select the first completion item and notify coc.nvim to
	" format on enter, <cr> could be remapped by other vim plugin
	inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

	" Use `[g` and `]g` to navigate diagnostics
	" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	nmap <silent> ]g <Plug>(coc-diagnostic-next)

	" GoTo code navigation.
	nmap <silent> <leader>gd <Plug>(coc-definition)
	nmap <silent> <leader>gs :call CocAction("jumpDefinition", "split")<CR>
	nmap <silent> <leader>gv :call CocAction("jumpDefinition", "vsplit")<CR>
	nmap <silent> <leader>gy <Plug>(coc-type-definition)
	nmap <silent> <leader>im <Plug>(coc-implementation)
	nmap <silent> <leader>rf <Plug>(coc-references)
	nmap <silent> <leader>rt <Plug>(coc-refactor)
	" Symbol renaming.
	nmap <silent> <leader>rn <Plug>(coc-rename)
	" nmap <silent> gd <Plug>(coc-definition)
	" nmap <silent> gy <Plug>(coc-type-definition)
	" nmap <silent> gi <Plug>(coc-implementation)
	" nmap <silent> gr <Plug>(coc-references)

	" 禁用`vim-go`中的K按键映射 使用coc.nvim的浮动窗口效果更好
	let g:go_doc_keywordprg_enabled = 0
	" Use K to show documentation in preview window.
	nnoremap <silent> K :call <SID>show_documentation()<CR>

	function! s:show_documentation()
		if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		elseif (coc#rpc#ready())
			call CocActionAsync('doHover')
		else
			execute '!' . &keywordprg . " " . expand('<cword>')
		endif
	endfunction

	" Highlight the symbol and its references when holding the cursor.
	autocmd CursorHold * silent call CocActionAsync('highlight')

	" " Formatting selected code.
	" xmap <leader>f  <Plug>(coc-format-selected)
	" nmap <leader>f  <Plug>(coc-format-selected)

	augroup mygroup
		autocmd!
		" Setup formatexpr specified filetype(s).
		autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
		" Update signature help on jump placeholder.
		autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	augroup end

	" " Applying codeAction to the selected region.
	" " Example: `<leader>aap` for current paragraph
	" xmap <leader>a  <Plug>(coc-codeaction-selected)
	" nmap <leader>a  <Plug>(coc-codeaction-selected)

	" " Remap keys for applying codeAction to the current buffer.
	" nmap <leader>ac  <Plug>(coc-codeaction)
	" " Apply AutoFix to problem on the current line.
	" nmap <leader>qf  <Plug>(coc-fix-current)

	" " Map function and class text objects
	" " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
	" xmap if <Plug>(coc-funcobj-i)
	" omap if <Plug>(coc-funcobj-i)
	" xmap af <Plug>(coc-funcobj-a)
	" omap af <Plug>(coc-funcobj-a)
	" xmap ic <Plug>(coc-classobj-i)
	" omap ic <Plug>(coc-classobj-i)
	" xmap ac <Plug>(coc-classobj-a)
	" omap ac <Plug>(coc-classobj-a)

	" Remap <C-f> and <C-b> for scroll float windows/popups.
	if has('nvim-0.4.0') || has('patch-8.2.0750')
		nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
		nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
		inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
		inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
		vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
		vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
	endif

	" " Use CTRL-S for selections ranges.
	" " Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
	" nmap <silent> <C-s> <Plug>(coc-range-select)
	" xmap <silent> <C-s> <Plug>(coc-range-select)

	" Add `:Format` command to format current buffer.
	command! -nargs=0 Format :call CocAction('format')

	" Add `:Fold` command to fold current buffer.
	command! -nargs=? Fold :call	 CocAction('fold', <f-args>)

	" Add `:OR` command for organize imports of the current buffer.
	command! -nargs=0 OR   :call	 CocAction('runCommand', 'editor.action.organizeImport')

	" Add (Neo)Vim's native statusline support.
	" NOTE: Please see `:h coc-status` for integrations with external plugins that
	" provide custom statusline: lightline.vim, vim-airline.
	set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

	" " Mappings for CoCList
	" " Show all diagnostics.
	" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
	" " Manage extensions.
	" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
	" " Show commands.
	" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
	" Find symbol of current document.
	nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
	" Search workspace symbols.
	nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
	" " Do default action for next item.
	" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
	" " Do default action for previous item.
	" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
	" " Resume latest coc list.
	" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

	nmap ff :CocCommand explorer<CR>

	" https://github.com/golang/tools/blob/master/gopls/doc/vim.md#cocnvim
	" autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
	" use silent! and CocAction ignore this error
	autocmd BufWritePre *.go silent! call CocAction('runCommand', 'editor.action.organizeImport')

	" https://github.com/neoclide/coc.nvim/blob/a9410fe8b0038d1700b43df36a4745149e92feac/doc/coc.cnx#L880
	autocmd CursorHold * silent call CocActionAsync('highlight')
	" hi CocHighlightText ctermfg=black ctermbg=72 guifg=black guibg=#689d6a
	" hi CoCHoverRange ctermfg=black ctermbg=72 guifg=black guibg=#689d6a
	hi CocHighlightText guibg=#ff8600 guifg=black
	" hi CoCHoverRange guibg=NONE guifg=#ff8600

	if has("nvim-0.5.0")
		set tagfunc=CocTagFunc
	endif
endif



" ===
" === tagbar
" ===
if isdirectory(expand("~/.vim/bundle/tagbar/"))
	" map
	map <leader>f :Tagbar<CR>

	" setting
	let g:tagbar_sort = 0
	let g:tagbar_autofocus = 1
	" let g:tagbar_ctags_bin = 'ctags'

	" FROM: https://github.com/TimothyYe/mydotfiles/blob/master/neovim/.config/nvim/rc/06.tagbar.vim
	let g:tagbar_type_go = {
		\ 'ctagstype' : 'go',
		\ 'kinds'	  : [
			\ 'p:package',
			\ 'i:imports:1',
			\ 'c:constants',
			\ 'v:variables',
			\ 't:types',
			\ 'n:interfaces',
			\ 'w:fields',
			\ 'e:embedded',
			\ 'm:methods',
			\ 'r:constructor',
			\ 'f:functions'
		\ ],
		\ 'sro' : '.',
		\ 'kind2scope' : {
			\ 't' : 'ctype',
			\ 'n' : 'ntype'
		\ },
		\ 'scope2kind' : {
			\ 'ctype' : 't',
			\ 'ntype' : 'n'
		\ },
		\ 'ctagsbin'  : 'gotags',
		\ 'ctagsargs' : '-sort -silent'
	\ }
endif



" ===
" === vista.vim
" ===
" noremap <leader>f :Vista coc<CR>
" noremap <c-t> :silent! Vista finder coc<CR>
" let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
" let g:vista_default_executive = 'ctags'
" let g:vista_fzf_preview = ['right:50%']
" let g:vista#renderer#enable_icon = 1
" let g:vista#renderer#icons = {
" \   "function": "\uf794",
" \   "variable": "\uf71b",
" \  }
" " function! NearestMethodOrFunction() abort
" " 	return get(b:, 'vista_nearest_method_or_function', '')
" " endfunction
" " set statusline+=%{NearestMethodOrFunction()}
" " autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
" let g:scrollstatus_size = 15



" ===
" === vim-table-mode
" ===
if isdirectory(expand("~/.vim/bundle/vim-table-mode"))
	noremap <leader>tm :TableModeToggle<CR>
	"let g:table_mode_disable_mappings = 1
	let g:table_mode_cell_text_object_i_map = 'k<Bar>'
endif



" ===
" === NERRDTree
" ===
" if isdirectory(expand("~/.vim/bundle/nerdtree"))
"     " map
"     map <leader>a :NERDTreeToggle<CR>
"     map <leader>d :NERDTreeFind<CR>

"     " setting
"     let NERDTreeQuitOnOpen = 1
"     let NERDTreeMouseMode = 2
"     let NERDTreeShowHidden = 1
"     let NERDTreeShowBookmarks = 1

"     " https://github.com/preservim/nerdtree#how-can-i-close-vim-if-the-only-window-left-open-is-a-nerdtree
"     " close vim if the only window left open is a NERDTree
"     autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" endif



" ===
" === web-devicons
" ===
" web-devicons {
" if isdirectory(expand("~/.vim/bundle/vim-devicons"))
"     " 文件夹前面的空格太多 https://github.com/ryanoasis/vim-devicons/issues/257#issuecomment-491274274
"     " 如果减少的话会和git修改重叠
"     " let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''
"     " let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
"     " let g:NERDTreeDirArrowExpandable = "\u00a0"
"     " let g:NERDTreeDirArrowCollapsible = "\u00a0"
" endif



" " ===
" " === ale
" " ===
" if isdirectory(expand("~/.vim/bundle/ale"))
"     " To specify which linters you want to run for each filetype, use the g:ale_linters variable (:help g:ale_linters).
"     " \ 'go': ['golint', 'golangci-lint','gopls', 'gofmt', 'govet'],
"     " \ 'go': ['gopls'],
"     let g:ale_linters = {
"         \ '*': ['trim_whitespace'],
"         \ 'python': [],
"         \ 'yaml': ['yamllint'],
"     \ }
"     let g:ale_fixers = {
"         \ 'go': ['gofmt', 'goimports', 'remove_trailing_lines', 'trim_whitespace'],
"     \ }
"     " Use just ESLint for linting and fixing files which end in '.foo.js'
"     let g:ale_pattern_options = {
"         \	'\.foo\.js$': {
"         \		'ale_linters': ['eslint'],
"         \		'ale_fixers': ['eslint'],
"         \	},
"     \ }

"     " nnoremap <leader>at :ALEToggle<CR>
"     map <F7> :ALEToggle<CR>

"     let g:ale_sign_error = '✗'
"     let g:ale_sign_warning = '⚡'
"     let g:ale_lint_on_enter = 0

"     let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']

"     let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

"     nmap sp <Plug>(ale_previous_wrap)
"     nmap sn <Plug>(ale_next_wrap)
" endif



" ===
" === rainbow
" ===
if isdirectory(expand("~/.vim/bundle/rainbow/"))
	let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

	" 使用 vim-devicons 之后文件见有中括号
	" https://github.com/ryanoasis/vim-devicons/issues/274#issuecomment-513560707
	let g:rainbow_conf = {
			\ 'separately': {
			\ 'nerdtree': 0
			\ }
		\ }
endif



" " ===
" " === fzf
" " ===
" if isdirectory(expand("~/.vim/bundle/fzf.vim/"))
"     " [Buffers] Jump to the existing window if possible
"     let g:fzf_buffers_jump = 1

"     " nnoremap <silent> <leader>b  :Buffers<CR>
"     " nnoremap <silent> <leader>f  :Ripgrep<CR>
"     nnoremap <silent> <leader>l  :Lines<CR>
"     nnoremap <silent> <leader>ff :Files<CR>
"     nnoremap <silent> <leader>rg :Rg<CR>
"     " nnoremap <silent> <leader>`  :Marks<CR>
"     " nnoremap <silent> <leader>ag :Ag<gR>
"     " nnoremap <silent> <leader>rg :Ripgrep<CR>
"     nnoremap <silent> <leader>h  :History<CR>
"     nnoremap <silent> <leader>C  :Commands<CR>
"     nnoremap <silent> <leader>ht :Helptags<CR>

"     " https://github.com/junegunn/fzf.vim/blob/ddc377c0d3b886f2046b70d087a4dd89c903fdc2/doc/fzf-vim.txt#L321
"     command! -bang -nargs=* Rg
"             \ call fzf#vim#grep(
"             \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
"             \   fzf#vim#with_preview(), <bang>0)
" endif




" ===
" === telescope.nvim
" ===
if isdirectory(expand("~/.vim/bundle/telescope.nvim"))
	" nnoremap <leader>ff <cmd>Telescope find_files<cr>
	" nnoremap <leader>fg <cmd>Telescope live_grep<cr>
	" nnoremap <leader>fb <cmd>Telescope file_browser<cr>
	" nnoremap <leader>fh <cmd>Telescope help_tags<cr>

	lua <<EOF
	require('telescope').setup {
		defaults = {
			prompt_prefix = '🔭 ',
			prompt_position = 'top',
			selection_caret = " ",
			sorting_strategy = 'ascending',
			results_width = 0.6,
		},
		extensions = {
			fzy_native = {
				override_generic_sorter = false,
				override_file_sorter = true,
			}
		}
	}
	require('telescope').load_extension('fzy_native')
EOF
end



" " ===
" " === vim-airline
" " ===
" if isdirectory(expand("~/.vim/bundle/vim-airline-themes/"))
"     if !exists('g:airline_powerline_fonts')
"         let g:airline_powerline_fonts = 1
"         " Use the default set of separators with a few customizations
"         let g:airline_left_sep='›'	" Slightly fancier than '>'
"         let g:airline_right_sep='‹' " Slightly fancier than '<'
"         if (1 || has("mac")) && !has("gui_macvim")		   " MacVim无法正常显示
"             let g:airline_left_sep=''	" Slightly fancier than '>'
"             let g:airline_right_sep='' " Slightly fancier than '<'
"         endif
"     endif

"     let g:airline#extensions#tabline#enabled = 1
"     let g:airline#extensions#tabline#buffer_nr_show = 1
"     let g:airline#extensions#tabline#buffer_idx_mode = 3
"     let g:airline#extensions#tabline#left_sep = ' '
"     let g:airline#extensions#tabline#left_alt_sep = '|'
"     let g:airline#extensions#tabline#formatter = 'unique_tail'
"     let g:airline#extensions#ale#error_symbol = "✗"
"     let airline#extensions#ale#warning_symbol = "⚡"
"     if (1 || has("mac")) && !has("gui_macvim")		   " MacVim无法正常显示
"         let g:airline#extensions#tabline#left_sep=''
"         let g:airline#extensions#tabline#left_alt_sep=''
"     endif

"     " <Space>1-9 切换到对应的序列
"     for i in range(1, 9)
"         exe printf('nmap <silent> <leader>%d <Plug>AirlineSelectTab%02d', i, i)
"     endfor
" endif



" ===
" === Plug galaxyline.nvim
" ===
if isdirectory(expand("~/.vim/bundle/galaxyline.nvim"))
	lua require("modules.ui.eviline")
end



" ===
" === Plug nvim-bufferline.lua
" ===
if isdirectory(expand("~/.vim/bundle/nvim-bufferline.lua"))
	lua require('bufferline').setup({
				\ options = {
					\ numbers = "ordinal",
					\ number_style = "subscript",
					\ mappings = true,
					\ modified_icon = '✥',
					\ buffer_close_icon = '',
					\ always_show_bufferline = false,
				\ },
			\})
endif



" ===
" === fugitive
" ===
if isdirectory(expand("~/.vim/bundle/vim-fugitive/"))
	nnoremap <silent> <leader>gs :Gstatus<CR>
	nnoremap <silent> <leader>gb :Gblame<CR>
	nnoremap <silent> <leader>gl :Glog<CR>
endif



" ===
" === gitgutter
" ===
if isdirectory(expand("~/.vim/bundle/vim-gitgutter/"))
	let g:gitgutter_diff_args = '-w'

	" 有时会出现git左侧状态栏不准确的问题 使用该命令可以强制刷新
	nmap <silent> <Leader>ll :GitGutterAll<CR>

	" highlight! link SignColumn LineNr
	" highlight GitGutterAdd	  guifg=#009900 ctermfg=2
	" highlight GitGutterChange guifg=#bbbb00 ctermfg=3
	" highlight GitGutterDelete guifg=#ff2222 ctermfg=1
	" let g:gitgutter_set_sign_backgrounds = 1

	let g:gitgutter_sign_allow_clobber = 0
	let g:gitgutter_map_keys = 0
	let g:gitgutter_override_sign_column_highlight = 0
	let g:gitgutter_preview_win_floating = 1
	let g:gitgutter_sign_added = '▎'
	let g:gitgutter_sign_modified = '░'
	let g:gitgutter_sign_removed = '▏'
	let g:gitgutter_sign_removed_first_line = '▔'
	let g:gitgutter_sign_modified_removed = '▒'

	nnoremap <LEADER>gf :GitGutterFold<CR>
	" nnoremap H :GitGutterPreviewHunk<CR>
	" nnoremap <LEADER>g- :GitGutterPrevHunk<CR>
	" nnoremap <LEADER>g= :GitGutterNextHunk<CR>
endif



" ===
" === nerdcommenter
" ===
if isdirectory(expand("~/.vim/bundle/nerdcommenter"))
	" 注释的时候自动加个空格,强迫症必配
	let g:NERDSpaceDelims = 1
endif



" ===
" === undotree
" ===
if isdirectory(expand("~/.vim/bundle/undotree/"))
	nnoremap <Leader>u :UndotreeToggle<CR>
	" nnoremap <F3>		 :UndotreeToggle<CR>
	" inoremap <F3> <C-O>:UndotreeToggle<CR>
	" If set to 1, the undotree window will get focus after being opened, otherwise focus will stay in current window.
	let g:undotree_SetFocusWhenToggle=1
endif



" ===
" === vimwiki
" ===
if isdirectory(expand("~/.vim/bundle/vimwiki"))
	let g:vimwiki_list = [{'path': '~/Dropbox/notebook/vimwiki/',
							\ 'syntax': 'markdown', 'ext': '.md'}]
endif



" ===
" " === grepper
" " ===
if isdirectory(expand("~/.vim/bundle/vim-grepper"))
	" 先加载了`g:grepper`才有值
	runtime plugin/grepper.vim

	let g:grepper.highlight = 1		" 高亮显示搜索内容
	let g:grepper.stop = 1000		" 查找到多少个后就停止搜索
	let g:grepper.switch = 0		" 自动切换到quickfix窗口

	" Search for the current word
	nnoremap <leader>* :Grepper -tool ag -cword -noprompt<CR>

	vnoremap <F4> <Esc>:<C-u>Rg -wS '<C-r>=GetVisual('rg')<CR>'  <C-h>
	nnoremap <expr> <F4> ":Rg -wS " . expand('<cword>') . ' '

	" Get the current visual block for search and replaces
	" This function passed the visual block through a string escape function
	" Based on this - https://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
	function! GetVisual(tool) range
		" Save the current register and clipboard
		let reg_save = getreg('"')
		let regtype_save = getregtype('"')
		let cb_save = &clipboard
		set clipboard&

		" Put the current visual selection in the " register
		normal! ""gvy
		let selection = getreg('"')

		" Put the saved registers and clipboards back
		call setreg('"', reg_save, regtype_save)
		let &clipboard = cb_save

		"Escape any special characters in the selection
		let l:escaped_selection = EscapeString(selection, a:tool)

		" 删除行尾换行符
		if strlen(l:escaped_selection) > 2 && l:escaped_selection[-2:] == '\n'
			let l:escaped_selection = l:escaped_selection[:-3]
		endif

		return l:escaped_selection
	endfunction
endif



" ===
" === far.vim
" ===
if isdirectory(expand("~/.vim/bundle/far.vim"))
	set lazyredraw            " improve scrolling performance when navigating through large results
	set regexpengine=1        " use old regexp engine
	set ignorecase smartcase  " ignore case only when the pattern contains no capital letters

	" shortcut for far.vim find
	nnoremap <silent> <Find-Shortcut>  :Farf<cr>
	vnoremap <silent> <Find-Shortcut>  :Farf<cr>

	" shortcut for far.vim replace
	nnoremap <silent> <Replace-Shortcut>  :Farr<cr>
	vnoremap <silent> <Replace-Shortcut>  :Farr<cr>
endif


" ===
" === vim-visual-multi
" ===
if isdirectory(expand("~/.vim/bundle/vim-visual-multi"))
	let g:VM_show_warnings = 0
	let g:VM_leader = '\\'
	let g:VM_maps = {}
	let g:VM_maps["Undo"] = 'u'
	let g:VM_maps["Redo"] = '<C-r>'
	let g:VM_maps["Add Cursor Down"]			 = '<M-j>'	   " 往下增加光标 Opt+j
	let g:VM_maps["Add Cursor Up"]				 = '<M-k>'	   " 往上增加光标 Opt+k
	" let g:VM_maps["Select All"]				   = '\\A'

	" Opt+h Opt+l 在多光标模式下 可以移动单个光标 而不是所有光标
	noremap <M-h> <Left>
	noremap <M-l> <Right>
endif



" " ===
" " === vim-startify
" " ===
" if isdirectory(expand("~/.vim/bundle/vim-startify"))
"     " https://github.com/mhinz/vim-startify/issues/374#issuecomment-496481547
"     function! s:center(lines) abort
"         let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
"         let centered_lines = map(copy(a:lines),
"             \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
"         return centered_lines
"     endfunction

"     " let g:startify_custom_header = s:center(startify#fortune#cowsay())
"     " let g:startify_custom_footer = s:center(['foo', 'bar', 'baz'])

"     " 是否自动加载目录下的Session.vim, 很好用
"     let g:startify_session_autoload = 1
"     " 过滤列表，支持正则表达式
"     let g:startify_skiplist = [
"         \ '^/tmp',
"         \ '^/vender',
"     \ ]
"     " 起始页显示的列表长度
"     let g:startify_files_number = 10

"     " http://patorjk.com/software/taag/#p=display&f=Graffiti&t=Type%20Something%20
"     let s:header = [
"         \ '',
"         \ '  ______         __                                      __     __           __            _                        __                             ',
"         \ ' /_  __/___     / /_  ___     ____  _____   ____  ____  / /_   / /_____     / /_  ___     (_)____   __  ______     / /_____     __  ______  __  __ ',
"         \ '  / / / __ \   / __ \/ _ \   / __ \/ ___/  / __ \/ __ \/ __/  / __/ __ \   / __ \/ _ \   / / ___/  / / / / __ \   / __/ __ \   / / / / __ \/ / / / ',
"         \ ' / / / /_/ /  / /_/ /  __/  / /_/ / /     / / / / /_/ / /_   / /_/ /_/ /  / /_/ /  __/  / (__  )  / /_/ / /_/ /  / /_/ /_/ /  / /_/ / /_/ / /_/ /  ',
"         \ '/_/  \____/  /_.___/\___/   \____/_/     /_/ /_/\____/\__/   \__/\____/  /_.___/\___/  /_/____/   \__,_/ .___/   \__/\____/   \__, /\____/\__,_/   ',
"         \ '                                                                                                      /_/                    /____/                ',
"         \ '',
"     \ ]

"     let s:footer = [
"         \ '+---------------------------------------------+',
"         \ '|                   ^_^                       |',
"         \ '|    Talk is cheap. Show me the code.         |',
"         \ '|                                             |',
"         \ '+---------------------------------------------+',
"     \ ]

"     " https://github.com/mhinz/vim-startify/issues/374#issuecomment-496501489
"     let g:startify_custom_header = s:center(s:header)
"     let g:startify_custom_footer = s:center(s:footer)
" endif



" ===
" === dashboard-nvim
" ===
if isdirectory(expand("~/.vim/bundle/dashboard-nvim"))
	" let g:dashboard_preview_command = "cat"
	" let g:dashboard_preview_pipeline = "lolcat"
	" let g:dashboard_preview_file = "~/.config/nvim/static/champly.txt"
	" let g:dashboard_preview_file_height = 12
	" let g:dashboard_preview_file_width = 58
	let g:dashboard_default_executive = "telescope"
	" let g:dashboard_default_executive = "fzf"
	
	let g:dashboard_custom_header = [
		\ '',
		\ '',
		\ '',
		\ '  ______         __                                      __     __           __            _                        __                             ',
		\ ' /_  __/___     / /_  ___     ____  _____   ____  ____  / /_   / /_____     / /_  ___     (_)____   __  ______     / /_____     __  ______  __  __ ',
		\ '  / / / __ \   / __ \/ _ \   / __ \/ ___/  / __ \/ __ \/ __/  / __/ __ \   / __ \/ _ \   / / ___/  / / / / __ \   / __/ __ \   / / / / __ \/ / / / ',
		\ ' / / / /_/ /  / /_/ /  __/  / /_/ / /     / / / / /_/ / /_   / /_/ /_/ /  / /_/ /  __/  / (__  )  / /_/ / /_/ /  / /_/ /_/ /  / /_/ / /_/ / /_/ /  ',
		\ '/_/  \____/  /_.___/\___/   \____/_/     /_/ /_/\____/\__/   \__/\____/  /_.___/\___/  /_/____/   \__,_/ .___/   \__/\____/   \__, /\____/\__,_/   ',
		\ '                                                                                                      /_/                    /____/                ',
		\ '',
	\ ]

	" let g:dashboard_footer_icon = "🐬 "
	let g:dashboard_custom_footer = [
				\ "If you think penguins are fat and waddle, you have never been attacked by one",
				\ "running at you in excess of 100 miles per hour.",
				\ "",
				\ "                                                            -- Linus Torvalds"
				\ ]

	let g:dashboard_custom_section = {
		\ "last_session": {
			\ "description": ["  Recently laset session                  leader sl"],
			\ "command": "SessionLoad"},
		\ "find_history": {
			\ "description": ["  Recently opened files                   leader fh"],
			\ "command": "DashboardFindHistory"},
		\ "find_file": {
			\ "description": ["  Find  File                              leader ff"],
			\ "command": "DashboardFindFile"},
		\ "find_word": {
			\ "description": ["  Find  word                              leader fw"],
			\ "command": "DashboardFindWord"},
		\ "new_buffer": {
			\ "description": ["  Create new buffer                       leader n "],
			\ "command": ":enew"},
	\}

	" let g:dashboard_custom_section = {
	"     \ "last_session": {
	"         \ "description": ["  Recently laset session                  leader s l"],
	"         \ "command": "SessionLoad"},
	"     \ "find_history": {
	"         \ "description": ["  Recently opened files                   leader f h"],
	"         \ "command": "DashboardFindHistory"},
	"     \ "find_file": {
	"         \ "description": ["  Find  File                              leader f f"],
	"         \ "command": "Telescope find_files find_command=rg,--hidden,--files"},
	"     \ "new_file": {
	"         \ "description": ["  File Browser                            leader f b"],
	"         \ "command": "Telescope file_browser"},
	"     \ "find_word": {
	"         \ "description": ["  Find  word                              leader f w"],
	"         \ "command": "DashboardFindWord"},
	"     \ "find_dotfiles": {
	"         \ "description": ["  Open Personal dotfiles                  leader f d"],
	"         \ "command": "Telescope dotfiles path=' .. home ..'/.dotfiles"},
	"     \ "go_source": {
	"         \ "description": ["  Find Go Source Code                     leader f s"],
	"         \ "command": "Telescope gosource"},
	" \}

	nnoremap <silent> <leader>ss :<C-u>SessionSave<CR>
	nnoremap <silent> <leader>sl :<C-u>SessionLoad<CR>	
	nnoremap <silent> <Leader>fh :DashboardFindHistory<CR>
	nnoremap <silent> <leader>fw :DashboardFindWord<CR>
	" nnoremap <silent> <leader>cn :DashboardNewFile<CR>
	" hi DashboardHeader guifg=blue
	" hi DashboardCenter guifg=green
	hi DashboardShortcut guifg=#1E90FF
	hi DashboardFooter guifg=gray
endif



" ===
" === vim-floaterm
" ===
if isdirectory(expand("~/.vim/bundle/vim-floaterm"))
	let g:floaterm_title = "zsh $1/$2"
	let g:floaterm_autoclose = 1
	" let g:floaterm_winblend = 60
	nnoremap <silent> <F3> :FloatermToggle<CR>
	tnoremap <silent> <F3> <C-\><C-n>:FloatermToggle<CR>
endif



" ===
" === vimspector
" ===
if isdirectory(expand("~/.vim/bundle/vim-sneak"))
	" https://tc500.github.io/%E5%B7%A5%E5%85%B7%E9%93%BE/2019/02/08/%E9%AB%98%E6%95%88%E7%9A%84vim/
	" 开启跳转标签
	let g:sneak#label = 1
	" 标签字符序列
	let g:sneak#target_labels = ";sftunq/SFGHLTUNRMQZ?0123456789"
	" " f正向查找字符，F反向查找字符
	nnoremap <silent> f :<C-U>call sneak#wrap('',           1, 0, 1, 1)<CR>
	nnoremap <silent> F :<C-U>call sneak#wrap('',           1, 1, 1, 1)<CR>
	xnoremap <silent> f :<C-U>call sneak#wrap(visualmode(), 1, 0, 1, 1)<CR>
	xnoremap <silent> F :<C-U>call sneak#wrap(visualmode(), 1, 1, 1, 1)<CR>
	onoremap <silent> f :<C-U>call sneak#wrap(v:operator,   1, 0, 1, 1)<CR>
	onoremap <silent> F :<C-U>call sneak#wrap(v:operator,   1, 1, 1, 1)<CR>
endif



" ===
" === vimspector
" ===
" let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
" function! s:read_template_into_buffer(template)
"     " has to be a function to avoid the extra space fzf#run insers otherwise
"     execute '0r ~/.config/nvim/vimspector_json/'.a:template
" endfunction
" command! -bang -nargs=* LoadVimSpectorJsonTemplate call fzf#run({
"             \   'source': 'ls -1 ~/.config/nvim/vimspector_json',
"             \   'down': 20,
"             \   'sink': function('<sid>read_template_into_buffer')
"             \ })
" noremap <leader>lt :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>
" sign define vimspectorBP text=🛑 texthl=Normal
" sign define vimspectorBPDisabled text=🚫 texthl=Normal
" sign define vimspectorPC text=👉 texthl=SpellBad



" ===
" === markdown-preview.nvim
" ===
if isdirectory(expand("~/.vim/bundle/markdown-preview.nvim"))
	" auto open browser
	" let g:mkdp_auto_start = 1
	noremap  <leader>kv :MarkdownPrevie<CR>
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



" ===
" === General
" ===
" quick open vimrc in a new tab
nnoremap <leader>v	:e $MYVIMRC<cr>
nnoremap <leader>s	:source $MYVIMRC<cr>

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
source ~/.config/nvim/Ultisnips/md-snippets.vim
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
inoremap <silent> <leader>w  <Esc>:wa<CR>
noremap	 <silent> <leader>w  :wa<CR>
inoremap <leader>wq <Esc>:wq<CR>
noremap  <leader>wq :wq<CR>
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

