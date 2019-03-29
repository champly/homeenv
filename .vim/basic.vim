" map the <Leader> key as ",",the default is "\"
let mapleader = ","
nnoremap <leader>ev :vs ~/.vim/basic.vim<CR>
nnoremap <leader>sv :source $MYVIMRC<cr>
" map kj as ESC while in the insert mode
imap kj <esc>
" automatically save file when do something else
set autowrite
" always set dir to current file's dir
set autochdir
" line number
set number

" 注释的时候自动加个空格,强迫症比配
let g:NERDSpaceDelims=1

set tabstop=4 
set shiftwidth=4

" backspace
set backspace=indent,eol,start

" molokai theme
let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai

" quickfix window
map <C-j> :cnext<CR>
map <C-k> :cprevious<CR>
nnoremap <leader>z :cclose<CR>

" CompleteParameter.vim
" inoremap <silent><expr> ( complete_parameter#pre_complete("()")
" smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
" imap <c-j> <Plug>(complete_parameter#goto_next_parameter)
" smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
" imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
" let g:AutoPairs = {'[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
" inoremap <buffer><silent> ) <C-R>=AutoPairsInsert(')')<CR>

" copy and paste
vmap <leader>y "+y
nmap <leader>p "+gp  
"vmap <leader>y :w !pbcopy<CR><CR>
"nmap <leader>p :r !pbpaste<CR><CR>  


" NERDTree
" toggle
map <leader>a :NERDTreeToggle<CR>
map <leader>d :NERDTreeFind<CR>

" 打开文件时关闭树
let NERDTreeQuitOnOpen=1

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" tagbar
map <leader>f :Tagbar<CR>
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

" diable the preview window
set completeopt-=preview


" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" 状态栏
set statusline=%F[%l/%L]

" 0 if you want to enable it later via :RainbowToggl
" let g:rainbow_active = 1 

" Yggdroot/indentLine
let g:indentLine_setColors = 0
let g:indentLine_color_term = 0
let g:indentLine_char = '¦'
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:artline#extensions#tabline#formatter = 'unique_tail'

set nu

set laststatus=2
let g:Powerline_symbols='unicode'

set hlsearch incsearch

map <F4> <Esc>:%!python -m json.tool<CR>

" persistent history
set undofile " Maintain undo history between sessions
set undodir=~/.vim/undodir
set rtp+=/usr/local/opt/fzf
