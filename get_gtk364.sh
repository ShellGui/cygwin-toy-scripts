#!/bin/sh

Work_Root=$(pwd)

. $Work_Root/http_proxy.conf

if [ ! -f $Work_Root/srcs/gtk364/gtk+-bundle_3.6.4-20130513_win32.zip ]; then
if ! md5sum $Work_Root/srcs/gtk364/gtk+-bundle_3.6.4-20130513_win32.zip | grep "e47c3c10a2d8c5267c210d875a9d5341"; then
mkdir -p $Work_Root/srcs/gtk364/
wget http://www.tarnyko.net/repo/gtk3_build_system/gtk+-bundle_3.6.4-20130513_win32.zip -P $Work_Root/srcs/gtk364/
fi
fi

if [ ! -d $Work_Root/srcs/gtk364/gtk+-bundle_3.6.4-20130513_win32 ]; then
cd $Work_Root/srcs/gtk364/
unzip gtk+-bundle_3.6.4-20130513_win32.zip -d gtk+-bundle_3.6.4-20130513_win32
fi
