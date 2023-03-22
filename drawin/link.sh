#!bin/bash

DropboxInstallPath=~/Library/CloudStorage/Dropbox
# DropboxInstallPath=~/Dropbox

# zsh
rm -rf ~/.zshrc
ln -s ${DropboxInstallPath}/config/zsh/zshrc ~/.zshrc
rm -rf ~/.zsh_history
ln -s ${DropboxInstallPath}/config/zsh/zsh_history ~/.zsh_history

# nvim
rm -rf ~/.config/nvim
rm -rf ~/.config/ranger
ln -s ${DropboxInstallPath}/config/nvim ~/.config/
ln -s ${DropboxInstallPath}/config/ranger ~/.config/

# clash
rm -rf ~/.config/clash
ln -s ${DropboxInstallPath}/config/clash ~/.config/

# karabiner
rm -rf ~/.config/karabiner
ln -s ${DropboxInstallPath}/config/karabiner ~/.config/

# git
rm -rf ~/.gitconfig
rm -rf ~/.ssh
ln -s ${DropboxInstallPath}/config/git/gitconfig ~/.gitconfig
ln -s ${DropboxInstallPath}/config/git/ssh ~/.ssh
chmod 600 ~/.ssh/github-rsa
chmod 600 ~/.ssh/gitlab_rsa
chmod 600 ~/.ssh/jumpserver

# kubeconf
rm -rf ~/.kube
mkdir ~/.kube
ln -s ${DropboxInstallPath}/config/kubeconfig ~/.kube/config

# gauth
rm -rf ~/.gauth
ln -s ${DropboxInstallPath}/config/gauth ~/.gauth

# # tmux
rm -rf ~/.tmux.conf
ln -s ${DropboxInstallPath}/config/tmux/tmux.conf ~/.tmux.conf

# # hosts
# sudo mv /etc/hosts /etc/hosts.bak
# sudo ln -s ${DropboxInstallPath}/config/hosts /etc/hosts
