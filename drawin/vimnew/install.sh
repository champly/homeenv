#!/bin/bash

# env
npm install -g neovim

# vim
brew remove vim
brew cleanup
brew install vim --with-python3

# neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
brew install neovim
pip3 install pynvim
npm install -g neovim

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

# font
brew tap homebrew/cask-fonts
brew cask install font-source-code-pro

# ag
brew install ripgrep
