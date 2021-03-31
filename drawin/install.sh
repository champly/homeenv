#!/bin/bash

echo "###### install brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

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
ln -s ~/Dropbox/config/zsh/zshrc ~/.zshrc
ln -s ~/Dropbox/config/zsh/zsh_history ~/.zsh_history
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-history-substring-search.git ~/.oh-my-zsh/plugins/zsh-history-substring-search
source ~/.zshrc

echo "###### install fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# update pip3
sudo pip3 install --upgrade pip

# install npm
brew install node
# config taobao registry
npm config set registry https://registry.npm.taobao.org
npm config set http-proxy http://127.0.0.1:1080
npm config set https-proxy http://127.0.0.1:1080

# vim
# brew remove vim
brew cleanup
# brew install vim --with-python3

# neovim
brew install --build-from-source --HEAD luajit
brew install --build-from-source --HEAD neovim
# brew install neovim --HEAD
# pip3 install pynvim
# npm install -g neovim

# nerd fonts
brew tap homebrew/cask-fonts
brew cask install font-sauce-code-pro-nerd-font

# ranger
pip3 install ranger-fm
brew install atool
brew install highlight
brew install jq

# lazygit
brew install jesseduffield/lazygit/lazygit

# figlet
brew install figlet

# tagbar
brew install gotags
brew unlink ctags
brew install --with-jansson --HEAD universal-ctags/universal-ctags/universal-ctags

# lolcat
brew install lolcat

# rg
brew install ripgrep

# c/c++
brew install ccls

# rust
# brew install rust
# brew install rust-analyzer
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rls rust-analysis rust-src

# graph easy
# https://juejin.cn/post/6844903510987767815
brew install graphviz
cpan Graph:Easy

sh ./link.sh
