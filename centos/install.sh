wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

# nodejs
curl -sL https://rpm.nodesource.com/setup_12.x | sudo bash -
yum clean all && sudo yum makecache fast
yum install -y gcc-c++ make
yum install -y nodejs

npm config set registry https://registry.npm.taobao.org

# nvim
wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
./nvim.appimage --appimage-extract
mv squashfs-root /usr/local/nvim

# vim ~/.bashrc
export PATH=$PATH:/usr/local/go/bin:/usr/local/nvim/usr/bin:/root/go/bin
