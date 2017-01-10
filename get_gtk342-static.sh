#!/bin/sh

Work_Root=$(pwd)

. $Work_Root/http_proxy.conf

if [ ! -f "$Work_Root/srcs/gtk342-static/gtk342_static-WIN32_(TARNYKO).zip" ]; then
if ! md5sum "$Work_Root/srcs/gtk342-static/gtk342_static-WIN32_(TARNYKO).zip" | grep "b9c8131f487aec176841df15f6abb3d8"; then
mkdir -p $Work_Root/srcs/gtk342-static/
wget "http://gtk.awaysoft.com/download/gtk342_static-WIN32_(TARNYKO).zip" -P $Work_Root/srcs/gtk342-static/
fi
fi

if [ ! -d $Work_Root/srcs/gtk342-static/gtk342 ]; then
cd $Work_Root/srcs/gtk342-static/
unzip "gtk342_static-WIN32_(TARNYKO).zip" -d gtk342
fi
