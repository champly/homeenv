#!bin/bash

SourcePath=~/go/src/github.com/champly/homeenv/drawin

Components="nvim joshuto gitui yazi starship.toml wezterm ghostty"

for cmp in ${Components};
do
	rm -rf ~/.config/${cmp}
	ln -s ${SourcePath}/${cmp} ~/.config/${cmp}
done

####### special
# tmux
rm -rf ~/.tmux.conf
ln -s ${SourcePath}/tmux/tmux.conf ~/.tmux.conf
