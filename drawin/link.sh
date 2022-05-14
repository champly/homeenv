#!bin/bash

# zsh
rm -rf ~/.zshrc
ln -s ~/Dropbox/config/zsh/zshrc ~/.zshrc
rm -rf ~/.zsh_history
ln -s ~/Dropbox/config/zsh/zsh_history ~/.zsh_history

# nvim
rm -rf ~/.config/nvim
rm -rf ~/.config/ranger
ln -s ~/Dropbox/config/nvim ~/.config/
ln -s ~/Dropbox/config/ranger ~/.config/

# clash
rm -rf ~/.config/clash
ln -s ~/Dropbox/config/clash ~/.config/

# karabiner
rm -rf ~/.config/karabiner
ln -s ~/Dropbox/config/karabiner ~/.config/

# git
rm -rf ~/.gitconfig
rm -rf ~/.ssh
ln -s ~/Dropbox/config/git/gitconfig ~/.gitconfig
ln -s ~/Dropbox/config/git/ssh ~/.ssh
chmod 600 ~/.ssh/github-rsa
chmod 600 ~/.ssh/gitlab_rsa
chmod 600 ~/.ssh/jumpserver

# kubeconf
rm -rf ~/.kube
mkdir ~/.kube
ln -s ~/Dropbox/config/kubeconfig ~/.kube/config

# gauth
rm -rf ~/.gauth
ln -s ~/Dropbox/config/gauth ~/.gauth

# # tmux
# rm -rf ~/.tmux.conf
# ln -s ~/Dropbox/config/tmux/tmux.conf ~/.tmux.conf

# # hosts
# sudo mv /etc/hosts /etc/hosts.bak
# sudo ln -s ~/Dropbox/config/hosts /etc/hosts

# vim
# rm -rf ~/.vimrc
# rm -rf ~/.vim
# mkdir ~/.vim
# ln -s ~/Dropbox/config/vim/vimrc ~/.vimrc 
# ln -s ~/Dropbox/config/vim/basic.vim ~/.vim/basic.vim
# ln -s ~/Dropbox/config/vim/python.vim ~/.vim/python.vim
# ln -s ~/Dropbox/config/vim/vim-go.vim ~/.vim/vim-go.vim
