#!/bin/bash

cd ~/download/
sudo yum -y install wget
sudo yum -y install glibc-static libstdc++-static
wget http://ftp.gnu.org/gnu/gcc/gcc-4.7.0/gcc-4.7.0.tar.gz
tar xvf gcc-4.7.0.tar.gz
cd gcc-4.7.0
./contrib/download_prerequisites
cd ..
mkdir build_gcc4.7
cd build_gcc4.7
../gcc-4.7.0/configure --enable-checking=release --enable-languages=c,c++ --disable-multilib
make -j4

sudo make install
