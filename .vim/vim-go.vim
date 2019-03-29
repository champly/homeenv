"au FileType go nmap <leader>rt <Plug>(go-run-tab)
"au FileType go nmap <leader>rs <Plug>(go-run-split)
"au FileType go nmap <leader>rv <Plug>(go-run-vertical)

"autocmd Filetype go nmap <leader>b  <Plug>(go-build)
autocmd Filetype go nmap <leader>r  <Plug>(go-run)
autocmd Filetype go nmap <leader>t  <Plug>(go-test)
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
autocmd Filetype go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

"au Filetype go nmap <leader>ds <Plug>(go-def-split)
"au Filetype go nmap <leader>dv <Plug>(go-def-vertical) "au Filetype go nmap <leader>dt <Plug>(go-def-tab)
au Filetype go nmap <leader>gd <Plug>(go-doc)
au Filetype go nmap <leader>gv <Plug>(go-doc-vertical)
au Filetype go nmap <leader>s <Plug>(go-implements)
au Filetype go nmap <leader>gb <Plug>(go-doc-browser)
au Filetype go nmap <leader>i <Plug>(go-info)
au Filetype go nmap <leader>e :GoReferrers<CR>
"au Filetype go nmap <leader>e <C-w>k<C-w>c
"au Filetype go nmap <leader>t :GoTestFunc<CR>


" auto import and format go code when saving
let g:go_fmt_command = "goimports"
" let the json name to be camelcase,the default is snake_case
"let g:go_snippet_case_type = "camelcase"
" go test's timeout
let g:go_test_timeout = '10s'

" beautify vim-go
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:syntastic_go_checkers = ['vet', 'golint', 'errcheck']
"let g:go_metalinter_autosave = 1
"let g:go_metalinter_autosave_enabled = ['vet', 'golint']
"let g:go_metalinter_autosave_enabled = ['vet']
let g:go_metalinter_deadline = "5s"

" do not pop up location lists
let g:go_list_type = "quickfix"
" the height of quickfix and locationlist
let g:go_list_height = 10

" auto display type info
" let g:go_auto_type_info = 1
" set updatetime=100

" highlight same variable,function or struct.
let g:go_auto_sameids = 1

let g:go_addtags_transform = "snakecase"
