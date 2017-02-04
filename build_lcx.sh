#!/bin/sh

Work_Root=$(pwd)

mkdir -p ${Work_Root}/srcs/lcx
cd ${Work_Root}/srcs/lcx
[ ! -f lcx.c ] && wget https://github.com/windworst/LCX/raw/master/lcx.c
i686-w64-mingw32-gcc lcx.c -o lcx  -lws2_32 -lwsock32

# ./lcx.exe -slave 10.10.11.254 5000 10.10.11.254 3389
# lcx –listen 5000 3389