# 配置python环境

```python
# create env
conda create -n pt python=3.7

# install pytorch
conda install pytorch torchvision cudatoolkit=9.0 cudnn -c pytorch

# some tools
pip install tqdm
# https://github.com/Lyken17/pytorch-OpCounter
pip install thop
pip install prefetch-generator

# install tensorboard
pip install tensorboardX
pip install tensorflow==1.13.1

# install pydensecrf：https://github.com/lucasb-eyer/pydensecrf
pip install cython
pip install git+https://github.com/lucasb-eyer/pydensecrf.git
```
