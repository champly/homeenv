#!bin/bash

SourcePath=~/go/src/github.com/champly/homeenv/drawin

Components="nix nvim joshuto gitui yazi starship.toml wezterm ghostty presenterm zellij"

for cmp in ${Components};
do
	rm -rf ~/.config/${cmp}
	ln -s ${SourcePath}/${cmp} ~/.config/${cmp}
done

####### special
# tmux
rm -rf ~/.tmux.conf
ln -s ${SourcePath}/tmux/tmux.conf ~/.tmux.conf

# alacritty
rm -rf ~/.config/alacritty/alacritty.toml
mkdir -p ~/.config/alacritty
ln -s ${SourcePath}/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
