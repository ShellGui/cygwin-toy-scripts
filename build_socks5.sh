#!/bin/sh

Work_Root=$(pwd)

cd ${Work_Root}/srcs/socks5-src

export LIB_EV="-L$Work_Root/srcs/libev_cygport/libev-4.24-1bl1.i686/inst/usr/lib/"
make clean
make libs
make bins

