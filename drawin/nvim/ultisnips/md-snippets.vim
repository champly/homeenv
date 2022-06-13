" autocmd Filetype markdown inoremap <buffer> mf <Esc>/<++><CR>:nohlsearch<CR>"_c4l
" autocmd Filetype markdown inoremap <buffer> mw <Esc>/ <++><CR>:nohlsearch<CR>"_c5l<CR>
autocmd Filetype markdown inoremap <buffer> mn ---<Enter><Enter>
autocmd Filetype markdown inoremap <buffer> mb ****<Space><++><Esc>F*hi
autocmd Filetype markdown inoremap <buffer> md ~~~~<Space><++><Esc>F~hi
autocmd Filetype markdown inoremap <buffer> mi **<Space><++><Esc>F*i
autocmd Filetype markdown inoremap <buffer> mk ``<Space><++><Esc>F`i
autocmd Filetype markdown inoremap <buffer> mc ```<Space><Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
autocmd Filetype markdown inoremap <buffer> mm - [ ] 
autocmd Filetype markdown inoremap <buffer> mp ![](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap <buffer> ma [](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap <buffer> m1 #<Space><Enter><Enter><++><Esc>kkA
autocmd Filetype markdown inoremap <buffer> m2 ##<Space><Enter><Enter><++><Esc>kkA
autocmd Filetype markdown inoremap <buffer> m3 ###<Space><Enter><Enter><++><Esc>kkA
autocmd Filetype markdown inoremap <buffer> m4 ####<Space><Enter><Enter><++><Esc>kkA
autocmd Filetype markdown inoremap <buffer> m5 #####<Space><Enter><Enter><++><Esc>kkA
autocmd Filetype markdown inoremap <buffer> m6 ######<Space><Enter><Enter><++><Esc>kkA
autocmd Filetype markdown inoremap <buffer> m7 #######<Space><Enter><Enter><++><Esc>kkA
autocmd Filetype markdown inoremap <buffer> ml --------<Enter>
autocmd Filetype markdown inoremap <buffer> mf <details><Enter><summary></summary><Enter><Enter><++><Enter></details><Esc>3k08la
