" plugin configuration
call plug#begin()

" a class outline viewer for Vim
Plug 'majutsushi/tagbar',  { 'on':  'Tagbar' }

" file explorer
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" theme
Plug 'fatih/molokai' 

Plug 'ctrlpvim/ctrlp.vim'

" comment
Plug 'scrooloose/nerdcommenter'

" json
Plug 'elzr/vim-json'

" quoting/parenthesizing
Plug 'tpope/vim-surround'

" auto close pairs
Plug 'jiangmiao/auto-pairs'

Plug 'vim-scripts/TaskList.vim'

" Track the engine.
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

" 一行代码分成多行显示或多行变一行
Plug 'AndrewRadev/splitjoin.vim'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" textobj
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-datetime'
Plug 'beloglazov/vim-textobj-quotes'
Plug 'sgur/vim-textobj-parameter'

Plug 'Valloric/YouCompleteMe'

Plug 'ervandew/supertab'

Plug 'skywind3000/asyncrun.vim'

" 异步检查语法
Plug 'w0rp/ale'

Plug 'danro/rename.vim'

" ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-bundler'

" rust
Plug 'rust-lang/rust.vim'

" yaml
Plug 'pearofducks/ansible-vim'

"Plug 'powerline/powerline',  {'rtp': 'powerline/bindings/vim/'}

" multi cursor (ctrl-n)
Plug 'terryma/vim-multiple-cursors'

Plug 'tpope/vim-fugitive'

Plug 'itchyny/lightline.vim'

Plug 'tpope/vim-markdown'

Plug 'tpope/vim-rhubarb'

Plug 'Shougo/denite.nvim'

Plug 'luochen1990/rainbow'

Plug 'kien/ctrlp.vim'

Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }

Plug 'airblade/vim-gitgutter'

" Plug 'tenfyzhong/CompleteParameter.vim'

Plug 'vim-airline/vim-airline'

Plug 'Yggdroot/indentLine'

" Add plugins to &runtimepath
call plug#end()

" function for config file execution
function s:cfg(name)
	execute 'source ~/.vim/'.a:name.'.vim'
endfunction

call  s:cfg("basic")
call  s:cfg("vim-go")
call  s:cfg("python")
" call  s:cfg("ruby")
