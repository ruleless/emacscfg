#!/bin/bash

cd /usr/src/Python-2.7.3/
./configure --prefix=/usr/local/python2.7
make all
make install
make clean
make distclean
