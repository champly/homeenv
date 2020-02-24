#!bin/bash

# zsh
rm -rf ~/.zshrc
ln -s ${githubPath}/drawin/zsh/zshrc ~/.zshrc

# vim
rm -rf ~/.vimrc
rm -rf ~/.vim/*.vim
ln -s ${githubPath}/drawin/vim/vimrc ~/.vimrc 
ln -s ${githubPath}/drawin/vim/basic.vim ~/.vim/basic.vim
ln -s ${githubPath}/drawin/vim/python.vim ~/.vim/python.vim
ln -s ${githubPath}/drawin/vim/vim-go.vim ~/.vim/vim-go.vim

# tmux
rm -rf ~/.tmux.conf
ln -s ${githubPath}/drawin/tmux/tmux.conf ~/.tmux.conf