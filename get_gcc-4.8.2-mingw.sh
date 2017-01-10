#!/bin/sh

Work_Root=$(pwd)

. $Work_Root/http_proxy.conf

if [ ! -f $Work_Root/srcs/gcc-4.8.2-mingw/i686-4.8.2-release-win32-sjlj-rt_v3-rev4.7z ]; then
if ! md5sum $Work_Root/srcs/gcc-4.8.2-mingw/i686-4.8.2-release-win32-sjlj-rt_v3-rev4.7z | grep "9ea4db85ed661e176a976be6313dd9ae"; then
mkdir -p $Work_Root/srcs/gcc-4.8.2-mingw/
wget "http://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/4.8.2/threads-win32/sjlj/i686-4.8.2-release-win32-sjlj-rt_v3-rev4.7z" -P $Work_Root/srcs/gcc-4.8.2-mingw/
fi
fi

if [ ! -d $Work_Root/srcs/gcc-4.8.2-mingw/mingw32 ]; then
cd $Work_Root/srcs/gcc-4.8.2-mingw/
7za x i686-4.8.2-release-win32-sjlj-rt_v3-rev4.7z
fi
