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
