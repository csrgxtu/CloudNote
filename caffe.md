### 在Ubuntu Server 14.04.3上面安装caffe
这个文档用来记录为信工院配置Deep Learning集群的过程

#### 基本依赖
```bash
sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
sudo apt-get install --no-install-recommends libboost-all-dev
```

##### 安装cuda
cuda 是针对Nvidia的GPU的库的计算封装
```bash
sudo dpkg -i cuda-repo-ubuntu1404-7-5-local_7.5-18_amd64.deb
sudo apt-get update
sudo apt-get install cuda

# environment setting, .bash.rc
export CUDA_HOME=/usr/local/cuda-7.5
export LD_LIBRARY_PATH=${CUDA_HOME}/lib64
PATH=${CUDA_HOME}/bin:${PATH}
export PATH
```
