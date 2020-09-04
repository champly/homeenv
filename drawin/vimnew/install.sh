#!/bin/bash

# vim
brew remove vim
brew cleanup
brew install vim --with-python3

# tagbar
brew install gotags
brew unlink ctags
brew install --HEAD universal-ctags/universal-ctags/universal-ctags

# font
brew tap homebrew/cask-fonts
brew cask install font-source-code-pro
