" FROM: https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
call plug#begin('~/.vim/bundle')

" Make sure you use single quotes

" file system explorer
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" go language support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" code-completion engine
Plug 'Valloric/YouCompleteMe'

" asynchronous lint engine
Plug 'dense-analysis/ale'

" annotate plugin: https://github.com/preservim/nerdcommenter#settings
Plug 'preservim/nerdcommenter'

" class outline viewer
Plug 'majutsushi/tagbar'

" parentheses improved
Plug 'luochen1990/rainbow'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Insert or delete brackets, parens, quotes in pair
Plug 'jiangmiao/auto-pairs'

" Lean & mean status/tabline for vim that's light as air.
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" VSCode theme
Plug 'tomasiser/vim-code-dark'
Plug 'morhetz/gruvbox'

" choice multi line
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'terryma/vim-multiple-cursors'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" tpope plug
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" The plug-in visualizes undo history and makes it easier to browse and switch between different undo branches
Plug 'mbbill/undotree'

" " help you create more human-friendly comments in your code
" [异常，停用]处理 function <SNR>2_update[1]..<SNR>2_update_impl[53]..<SNR>2_prepare[37]..FileType 自动命令 "*"..function <SNR>64_BetterComments[11]..<SNR>64_AddMatchesGroup 时发生错误:
" Plug 'jbgutierrez/vim-better-comments' 

" VimWiki is a personal wiki for Vim
Plug 'vimwiki/vimwiki'

" syntax highlighting, matching rules and mapping for the original Markdown and extensions
Plug 'plasticboy/vim-markdown'

" quick find word
Plug 'mhinz/vim-grepper'

" Initialize plugin system
call plug#end()

" map the <Leader> key as ",",the default is "\"
let mapleader = ","

" Formatting {
    set enc=utf-8

    source $VIMRUNTIME/vimrc_example.vim

    set textwidth=120       " 设置自动加上换行符的长度
    set relativenumber      " 显示相对行号
    set number              " 默认显示数字栏
    set nobackup            " 不需要备份文件，保留撤销文件
    " set nowritebackup		" 编辑的时候不需要备份文件
    " set noswapfile			" 表示不创建临时交换文件

    if has('persistent_undo')
        set undofile
        set undodir=~/.vim/undodir
        if !isdirectory(&undodir)
            call mkdir(&undodir, 'p', 0700)
        endif
    endif

    " if has('mouse')
    "     if has('gui_running') || (&term =~ 'xterm' && !has('mac'))
    "         set mouse=a
    "     else
    "         set mouse=nvi
    "     endif
    " endif
    set mouse=v	
    
    set scrolloff=1                 " Minimal number of screen lines to keep above and below the cursor.
    set tabstop=4                   " An indentation every four columns
    set shiftwidth=4
    set softtabstop=4               " Let backspace delete indent
    set autoindent
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    set smartindent                 " Open smart indent

    " 设置json双引号显示
    let g:vim_json_syntax_conceal = 0

    " 在Vim中更改quickfix窗口的默认位置 窗口到最下方
    " https://stackoverflow.com/questions/6726783/changing-default-position-of-quickfix-window-in-vim
    " 目前的问题是 偶尔需要手动执行 MiniBufExplorer
    autocmd! FileType qf wincmd J

    " https://github.com/mhinz/vim-grepper/issues/117
    augroup vimrcQfClose
        autocmd!
        autocmd FileType qf if mapcheck('<esc>', 'n') ==# '' | nnoremap <buffer><silent> <esc> :cclose<bar>lclose<CR> | endif
    augroup END
" }

" Vim UI {
    if has('gui_running')
        set guifont='SourceCodeProForPowerline-Regular:h13'
        set guifontwide='SourceCodeProForPowerline-Regular:h13'
    endif

    if isdirectory(expand("~/.vim/bundle/vim-code-dark"))
        colorscheme codedark
    endif
    
    " if isdirectory(expand("~/.vim/bundle/gruvbox"))
        " set bg=light
        " colorscheme gruvbox
    " endif
    
    " 设置光标所在行、列高亮
    " set cursorcolumn
    set cursorline
    
    set hlsearch
    " ctermfg => :help cterm-colors
    " https://github.com/eikenb/terminal-colors look at all color
    hi Search term=standout ctermfg=0 ctermbg=3

    if has('termguicolors') && ($COLORTERM == 'truecolor' || $COLORTERM == '24bit')
        set termguicolors
        " dark
        hi Search guibg=#d78700 guifg=#ffd700
        hi CursorLine guibg=#383838 guifg=NONE
        " " light
        " hi Search guibg=NONE guifg=#ff8700
        " hi CursorLine guibg=#ffffaf guifg=NONE
    endif
" }

" Vim-go {
    augroup _vim_go_
        " https://github.com/fatih/vim-go/blob/bd56f5690807d4a92652fe7a4d10dc08f260564e/doc/vim-go.txt#L938
        " example:   au FileType go nmap <leader>r <Plug>(go-run)

        au FileType go nmap <leader>im <Plug>(go-implements)
        au FileType go nmap <leader>rf <Plug>(go-referrers)
        au FileType go nmap <leader>if <Plug>(go-info)
        au FileType go nmap <Leader>rn <Plug>(go-rename)
        au FileType go nmap <Leader>ds <Plug>(go-def-split)
        au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
        au FileType go nmap <Leader>dt <Plug>(go-def-tab)
    augroup END

    " https://github.com/golang/tools/blob/master/gopls/doc/vim.md#vim-go
    let g:go_implements_mode = 'gopls'
    let g:go_def_mode='gopls'
    let g:go_info_mode='gopls'

    " https://github.com/fatih/vim-go/blob/bd56f5690807d4a92652fe7a4d10dc08f260564e/doc/vim-go.txt#L2589
    let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
    let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

    let g:go_fmt_command = "goimports"

    let g:go_highlight_types = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_extra_types = 1
    let g:go_highlight_build_constraints = 1
    let g:go_highlight_generate_tags = 1
    let g:go_auto_sameids = 1           " Use this option to highlight all uses of the identifier under the cursor
    let g:go_list_type = "quickfix"     " do not pop up location lists
    let g:go_list_height = 10           " the height of quickfix and locationlist

    " 切换是否自动显示单词引用
    " nnoremap <silent> <F3>      :GoSameIdsAutoToggle<CR>
    " inoremap <silent> <F3> <C-O>:GoSameIdsAutoToggle<CR>
" }


" YouCompleteMe {
    if isdirectory(expand("~/.vim/bundle/YouCompleteMe"))
        " https://github.com/ycm-core/YouCompleteMe/issues/2015#issuecomment-189917191
        set completeopt-=preview

        " 长期停留不自动文档提示
        let g:ycm_auto_hover = ''
        " 写注释的时候也能自动提示
        let g:ycm_complete_in_comments = 1
        " 只在下面的文件列表里面提示
        let g:ycm_filetype_whitelist = {
              \ 'go': 1,
              \ 'c': 1,
              \ 'cpp': 1,
              \ 'python': 1,
              \ 'vim': 1,
              \ 'sh': 1,
              \ 'zsh': 1,
              \ }
        " 当跳转的文件没有打开的时候分隔窗口的方式打开
        let g:ycm_goto_buffer_command = 'split-or-existing-window'
        " 提示键映射
        " let g:ycm_key_invoke_completion = '<C-Z>'
    endif
" }

" TagBar {
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
            \ 'kinds'     : [
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
"}

" NERDTree {
    if isdirectory(expand("~/.vim/bundle/nerdtree"))
        " map
        map <leader>a :NERDTreeToggle<CR>
        map <leader>d :NERDTreeFind<CR>

        " setting
        let NERDTreeQuitOnOpen = 1
        let NERDTreeMouseMode = 2
        let NERDTreeShowHidden = 1
        let NERDTreeShowBookmarks = 1

        " https://github.com/preservim/nerdtree#how-can-i-close-vim-if-the-only-window-left-open-is-a-nerdtree
        " close vim if the only window left open is a NERDTree
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    endif
" }

" ale Config {
    " To specify which linters you want to run for each filetype, use the g:ale_linters variable (:help g:ale_linters).
    " \ 'go': ['golint', 'golangci-lint','gopls', 'gofmt', 'govet'],
    let g:ale_linters = {
        \ '*': ['trim_whitespace'],
        \ 'go': ['gopls'],
        \ 'python': [],
        \ 'yaml': ['yamllint'],
    \ }
    let g:ale_fixers = {
        \ 'go': ['gofmt', 'goimports', 'remove_trailing_lines', 'trim_whitespace'],
    \ }
    " Use just ESLint for linting and fixing files which end in '.foo.js'
    let g:ale_pattern_options = {
        \   '\.foo\.js$': {
        \       'ale_linters': ['eslint'],
        \       'ale_fixers': ['eslint'],
        \   },
    \ }

    " nnoremap <leader>at :ALEToggle<CR>
    map <F7> :ALEToggle<CR>

    let g:ale_sign_error = '✗'
    let g:ale_sign_warning = '⚡'
    let g:ale_lint_on_enter = 0

    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" }

" Rainbow {
    if isdirectory(expand("~/.vim/bundle/rainbow/"))
        let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
    endif
" }

" fzf {
    if isdirectory(expand("~/.vim/bundle/fzf.vim/"))
        " [Buffers] Jump to the existing window if possible
        let g:fzf_buffers_jump = 1

        " nnoremap <silent> <leader>b  :Buffers<CR>
        " nnoremap <silent> <leader>f  :Ripgrep<CR>
        " nnoremap <silent> <leader>l  :Lines<CR>
        nnoremap <silent> <leader>p  :Files<CR>
        " nnoremap <silent> <leader>`  :Marks<CR>
        " nnoremap <silent> <leader>ag :Ag<gR>
        " nnoremap <silent> <leader>rg :Ripgrep<CR>
        nnoremap <silent> <leader>h  :History<CR>
        nnoremap <silent> <leader>C  :Commands<CR>
        nnoremap <silent> <leader>ht :Helptags<CR>
    endif
" }

" vim-airline {
    if isdirectory(expand("~/.vim/bundle/vim-airline-themes/"))
        if !exists('g:airline_theme')
            let g:airline_theme = 'codedark'
            " let g:airline_theme = 'gruvbox'
        endif

        if !exists('g:airline_powerline_fonts')
            let g:airline_powerline_fonts = 1
            " Use the default set of separators with a few customizations
            let g:airline_left_sep='›'  " Slightly fancier than '>'
            let g:airline_right_sep='‹' " Slightly fancier than '<'
            if (1 || has("mac")) && !has("gui_macvim")         " MacVim无法正常显示
                let g:airline_left_sep=''  " Slightly fancier than '>'
                let g:airline_right_sep='' " Slightly fancier than '<'
            endif
        endif

        let g:airline#extensions#tabline#enabled = 1
        let g:airline#extensions#tabline#buffer_nr_show = 1
        let g:airline#extensions#tabline#buffer_idx_mode = 3
        let g:airline#extensions#tabline#left_sep = ' '
        let g:airline#extensions#tabline#left_alt_sep = '|'
        let g:airline#extensions#tabline#formatter = 'unique_tail'
        if (1 || has("mac")) && !has("gui_macvim")         " MacVim无法正常显示
            let g:airline#extensions#tabline#left_sep=''
            let g:airline#extensions#tabline#left_alt_sep=''
        endif

        " <Space>1-9 切换到对应的序列
        for i in range(1, 9)
            exe printf('nmap <silent> <leader>%d <Plug>AirlineSelectTab%02d', i, i)
        endfor
    endif
" }

" Fugitive {
    if isdirectory(expand("~/.vim/bundle/vim-fugitive/"))
        nnoremap <silent> <leader>gs :Gstatus<CR>
    endif
"}

" gitgutter Config {
    if isdirectory(expand("~/.vim/bundle/vim-gitgutter/"))
        let g:gitgutter_diff_args = '-w'

        " 有时会出现git左侧状态栏不准确的问题 使用该命令可以强制刷新
        nmap <silent> <Leader>ll :GitGutterAll<CR>

        highlight! link SignColumn LineNr
        highlight GitGutterAdd    guifg=#009900 ctermfg=2
        highlight GitGutterChange guifg=#bbbb00 ctermfg=3
        highlight GitGutterDelete guifg=#ff2222 ctermfg=1
        let g:gitgutter_set_sign_backgrounds = 1
    endif
" }

" nerdcommenter Config {
    if isdirectory(expand("~/.vim/bundle/nerdcommenter"))
        " 注释的时候自动加个空格,强迫症必配
        let g:NERDSpaceDelims = 1
    endif
" }

" undotree Config {
    if isdirectory(expand("~/.vim/bundle/undotree/"))
        nnoremap <Leader>u :UndotreeToggle<CR>
        " nnoremap <F3>      :UndotreeToggle<CR>
        " inoremap <F3> <C-O>:UndotreeToggle<CR>
        " If set to 1, the undotree window will get focus after being opened, otherwise focus will stay in current window.
        let g:undotree_SetFocusWhenToggle=1
    endif
" }

" Functions {
    " 循环设置鼠标
    let g:set_mouse_value = &mouse  " 获取当前的mouse值 :set mouse?
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
" }

" vimwiki Config {
    if isdirectory(expand("~/.vim/bundle/vimwiki"))
        let g:vimwiki_list = [{'path': '~/Dropbox/notebook/vimwiki/',
                          \ 'syntax': 'markdown', 'ext': '.md'}]
    endif
" }

" grepper Config {
    if isdirectory(expand("~/.vim/bundle/vim-grepper"))	
        " 先加载了`g:grepper`才有值
        runtime plugin/grepper.vim

        let g:grepper.highlight = 1     " 高亮显示搜索内容
        let g:grepper.stop = 5000       " 查找到多少个后就停止搜索
        let g:grepper.switch = 0        " 自动切换到quickfix窗口

        " Search for the current word
        nnoremap <leader>* :Grepper -tool ag -cword -noprompt<CR>
    endif
" }

" vim-visual-multi Config {
    if isdirectory(expand("~/.vim/bundle/vim-visual-multi"))
        let g:VM_show_warnings = 0
        let g:VM_leader = '\\'
        let g:VM_maps = {}
        let g:VM_maps["Undo"] = 'u'
        let g:VM_maps["Redo"] = '<C-r>'
        let g:VM_maps["Add Cursor Down"]             = '<M-j>'     " 往下增加光标 Opt+j
        let g:VM_maps["Add Cursor Up"]               = '<M-k>'     " 往上增加光标 Opt+k
        " let g:VM_maps["Select All"]                  = '\\A'
        
        " Opt+h Opt+l 在多光标模式下 可以移动单个光标 而不是所有光标
        noremap <M-h> <Left>
        noremap <M-l> <Right>	
    endif
" }

" General {
    " quick open vimrc in a new tab
    nnoremap <leader>v  :e $MYVIMRC<cr>
    nnoremap <leader>s  :source $MYVIMRC<cr>

    " hidden not save buffer
    set hidden

    " 开启新的无名缓冲区
    nnoremap <leader>n  :enew<CR>
    nnoremap <leader>bd :bd!<CR>

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
" }

" command line mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>

" 使用 leader+w 在插入和normal模式下保存文件，我经常在 insert 模式下代替 Esc
inoremap <leader>w  <Esc>:w<CR>
noremap	 <leader>w	:w<CR>
inoremap <leader>wq <Esc>:wq<CR>
noremap  <leader>wq :wq<CR>
" 导致关闭quickfix leader q 延迟
" noremap  <leader>qq :q!<CR>

" 插入模式下移动光标位置 {
    " 放在最后面 避免被前面插件定义的快捷键覆盖了
    inoremap <C-h> <left>
    inoremap <C-j> <C-o>gj
    inoremap <C-k> <C-o>gk
    inoremap <C-l> <Right>
    inoremap <C-a> <Home>
    inoremap <C-e> <End>
    inoremap <C-b> <Left>
    inoremap <C-f> <Right>
" }

" 移动光标所在的窗口 {
    noremap <C-J> <C-W>j
    noremap <C-K> <C-W>k
    noremap <C-H> <C-W>h
    noremap <C-L> <C-W>l
" }

" 停止搜索高亮的键映射
nnoremap <silent> <F2>      :nohlsearch<CR>
inoremap <silent> <F2> <C-O>:nohlsearch<CR>
