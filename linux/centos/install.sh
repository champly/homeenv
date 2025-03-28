#!/bin/bash

wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

# nodejs
curl -fsSL https://rpm.nodesource.com/setup_20.x | sudo bash -
yum clean all && sudo yum makecache fast
yum install -y gcc-c++ make
yum install -y nodejs
npm install -g yarn

npm config set registry https://registry.npm.taobao.org

# nvim
# wget https://github.com/neovim/neovim-releases/releases/latest/download/nvim-linux-x86_64.appimage
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.appimage
chmod 755 ./nvim-linux-x86_64.appimage
./nvim-linux-x86_64.appimage --appimage-extract
rm -rf /usr/local/nvim
mv squashfs-root /usr/local/nvim

# vim ~/.bashrc
export PATH=$PATH:/usr/local/go/bin:/usr/local/nvim/usr/bin:/root/go/bin

# starship
curl -sS https://starship.rs/install.sh | sh

# zsh
yum install -y zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s /bin/zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions

# vim ~/.zshrc
# ZSH_THEME="ys"
# plugins=(
#   git
#   git-flow
#   docker
#   kubectl
#   brew
#   helm
#   zsh-autosuggestions
#   zsh-syntax-highlighting
#   zsh-history-substring-search
#   zsh-completions
# )

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
