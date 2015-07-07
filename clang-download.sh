#!/bin/bash

echo "进入Download目录"
cd ~/download

#下载源码
echo "下载llvm"
svn co http://llvm.org/svn/llvm-project/llvm/trunk llvm
cd llvm/tools
echo "下载clang"
svn co http://llvm.org/svn/llvm-project/cfe/trunk clang
cd ../..
cd llvm/tools/clang/tools
echo "下载extra"
svn co http://llvm.org/svn/llvm-project/clang-tools-extra/trunk extra
cd ../../../..
cd llvm/projects
echo "下载copiler-rt"
svn co http://llvm.org/svn/llvm-project/compiler-rt/trunk compiler-rt
cd ../..
