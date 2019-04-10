export MANPATH="/usr/local/man:$MANPATH"
export LANG=zh_CN.UTF-8
export TERM=xterm-256color

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# cuda
export PATH=/usr/local/cuda-9.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

# added by Miniconda3 installer
export PATH="/home/lart/miniconda3/bin:$PATH"

# Tex
export PATH=/home/lart/texlive/2018/bin/x86_64-linux:$PATH
export MANPATH=/home/lart/texlive/2018/texmf-dist/doc/man:$MANPATH
export INFOPATH=/home/lart/texlive/2018/texmf-dist/doc/info:$INFOPATH

# other script
export PATH=/home/lart/.local/bin:$PATH
