#!/bin/bash

DropboxInstallPath=~/Library/CloudStorage/Dropbox
# DropboxInstallPath=~/Dropbox

echo "###### install brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# brew install zsh
echo $SHELL
cat /etc/shells

echo "###### default zsh"
chsh -s /bin/zsh

echo "###### install oh-my-zsh"
rm -rf ~/.zshrc
rm -rf ~/.zsh_history
rm -rf ~/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "###### config zsh"
rm -rf ~/.zshrc
rm -rf ~/.zsh_history
ln -s ${DropboxInstallPath}/config/zsh/zshrc ~/.zshrc
ln -s ${DropboxInstallPath}/config/zsh/zsh_history ~/.zsh_history
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-history-substring-search.git ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-completions.git ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins ~/.oh-my-zsh/custom/plugins/autoupdate

source ~/.zshrc

echo "###### install fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# update pip3
sudo pip3 install --upgrade pip

# install npm and yarn
brew install node
brew install yarn
# config taobao registry
npm config set registry https://registry.npm.taobao.org
npm config set http-proxy http://127.0.0.1:1080
npm config set https-proxy http://127.0.0.1:1080

# vim
# brew remove vim
brew cleanup
# brew install vim --with-python3

# neovim
# brew install --build-from-source --HEAD luajit
# brew install --build-from-source --HEAD neovim
# brew install neovim --HEAD
brew install neovim
pip3 install pynvim
# npm install -g neovim

# tmux
brew install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# pip3 install powerline-status
pip3 install psutil

# nerd fonts
brew tap homebrew/cask-fonts
brew install --cask font-sauce-code-pro-nerd-font

# objdump & readelf tools
brew install binutils

# ranger
# pip3 install ranger-fm
# brew install ranger
brew install yazi
brew install atool
brew install highlight
brew install jq

# lazygit
brew install jesseduffield/lazygit/lazygit
brew install lazygit

# figlet
brew install figlet

# # tagbar
# brew install gotags
# brew unlink ctags
# brew install --with-jansson --HEAD universal-ctags/universal-ctags/universal-ctags

# golangci-lint
brew install golangci-lint
# go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

# lolcat
brew install lolcat

# rg & fd
brew install ripgrep
brew install fd

# c/c++
brew install ccls

# k9s
brew install k9s

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rust-analyzer rust-src
# https://rust-lang.github.io/rustup/concepts/components.html
rustup toolchain install nightly --component rust-analyzer

# install rz sz
brew install lrzsz

# install presenterm
brew install presenterm
npm install -g @mermaid-js/mermaid-cli

# graph easy
# https://juejin.cn/post/6844903510987767815
brew install graphviz
cpan Graph:Easy

brew install schappim/ocr/ocr

sh ./link.sh

# update
# yarn global upgrade
# npm outdated -g
# npm update -g
