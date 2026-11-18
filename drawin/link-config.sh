#!bin/bash

SourcePath=~/go/src/github.com/champly/homeenv/drawin

# Components="nix nvim joshuto gitui yazi starship.toml wezterm ghostty presenterm alacritty zellij rex"
Components="nvim yazi starship.toml ghostty rex"

for cmp in ${Components};
do
	rm -rf ~/.config/${cmp}
	ln -s ${SourcePath}/${cmp} ~/.config/${cmp}
done

####### special
# tmux
rm -rf ~/.tmux.conf
ln -s ${SourcePath}/tmux/tmux.conf ~/.tmux.conf
# zshrc
rm -rf ~/.zshrc
ln -s ${SourcePath}/zsh/zshrc ~/.zshrc
