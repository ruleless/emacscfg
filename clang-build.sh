#!/bin/bash

echo "进入Download目录"
cd ~/download

#编译
mkdir buildllvm
cd buildllvm
../llvm/configure  --enable-optimized --enable-targets=host-only
echo "编译..."
sudo make
echo "安装..."
sudo make install
