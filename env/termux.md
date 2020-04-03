主要参考：http://www.huangpan.net/posts/ji-ke/2019-08-19-termux.html

执行脚本前，先将Linux风格的shebang转换为Termux适用的shebang：`termux-fix-shebang initial_script.sh`。之后可以通过执行`sh initial_script.sh`即可

```sh
echo "1 更新源，其实没必要换源，有时候换源也会出现问题，直接原始源速度也可以，过程中询问是否升级，直接回车，使用默认即可 ==>> "
pkg update

echo "2 安装必要工具 ==>> "
pkg install curl wget git unzip unrar htop

echo "3 安装开发环境 ==>> "
pkg install python clang vim-python

echo "3.1 配置pip ==>> "
mkdir $HOME/.pip

cat>$HOME/.pip/pip.conf<<EOF
[global]
index-url = https://pypi.mirrors.ustc.edu.cn/simple/
EOF

echo "3.2 配置conda ==>> "
# conda的安装需要先安装好clang
pip install conda

cat>$HOME/.condarc<<EOF
# https://mirrors.tuna.tsinghua.edu.cn/help/anaconda/
channels:
  - defaults
show_channel_urls: true
channel_alias: https://mirrors.tuna.tsinghua.edu.cn/anaconda
default_channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/pro
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/msys2
custom_channels:
  conda-forge: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  msys2: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  bioconda: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  menpo: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  pytorch: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  simpleitk: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
EOF

echo "3.3 创建conda环境，名为py38 ==>> "
conda create -n py38 python=3.8

echo "4 安装ssh ==>> "
pkg install openssh

echo "5 开启读取文件目录的权限 ==>> "
termux-setup-storage

echo "6 从用户目录下的download文件夹读取termux.pub写入.ssh文件夹的认证文件中，并启动ssh服务 ==>> "
cat $HOME/storage/termux.pub > authorized_keys
sshd

echo "7 Termux键盘设置 ==>> "
mkdir $HOME/.termux
echo "extra-keys = [['ESC','/','-','HOME','UP','END','PGUP'],['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN']]" >> $HOME/.termux/termux.properties

echo "8 调整问候语 ==>> "
cp $PREFIX/etc/motd $PREFIX/etc/motd.backup
echo "Welcome to Termux! 请小心行事!" > $PREFIX/etc/motd

echo "9 打开休眠锁，更好地完成后台任务 ==>> "
termux-wake-lock

echo "10 利用proot来模拟root环境，在管理员身份下，输入exit或者快捷键CTRL+D可回到普通用户身份 ==>> "
pkg install proot

echo "11 Termux与Android信息 ==>> "
termux-info

echo "12 输出用户名和ip ==>> "
whoami
ifconfig

echo "完成安装"
```
