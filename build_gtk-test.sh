#!/bin/sh

Work_Root=$(pwd)

. $Work_Root/http_proxy.conf

# 下载源码
src_file="libglade_2.6.4-1_win32.zip"
if [ ! -f $Work_Root/dl/${src_file} ]; then
	wget -t 1 http://ftp.gnome.org/pub/gnome/binaries/win32/libglade/2.6/${src_file} -O $Work_Root/dl/tmp_file
	if [ $? -ne 0 ]; then
		rm -f $Work_Root/dl/tmp_file
		echo "${src_file} 下载失败"
		exit
	else
		mv -f $Work_Root/dl/tmp_file $Work_Root/dl/${src_file}
	fi
fi

src_file="libglade-dev_2.6.4-1_win32.zip"
if [ ! -f $Work_Root/dl/${src_file} ]; then
	wget -t 1 http://ftp.gnome.org/pub/gnome/binaries/win32/libglade/2.6/${src_file} -O $Work_Root/dl/tmp_file
	if [ $? -ne 0 ]; then
		rm -f $Work_Root/dl/tmp_file
		echo "${src_file} 下载失败"
		exit
	else
		mv -f $Work_Root/dl/tmp_file $Work_Root/dl/${src_file}
	fi
fi

src_file="libxml2_2.9.0-1_win32.zip"
if [ ! -f $Work_Root/dl/${src_file} ]; then
	wget -t 1 http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/${src_file} -O $Work_Root/dl/tmp_file
	if [ $? -ne 0 ]; then
		rm -f $Work_Root/dl/tmp_file
		echo "${src_file} 下载失败"
		exit
	else
		mv -f $Work_Root/dl/tmp_file $Work_Root/dl/${src_file}
	fi
fi

src_file="libxml2-dev_2.9.0-1_win32.zip"
if [ ! -f $Work_Root/dl/${src_file} ]; then
	wget -t 1 http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/${src_file} -O $Work_Root/dl/tmp_file
	if [ $? -ne 0 ]; then
		rm -f $Work_Root/dl/tmp_file
		echo "${src_file} 下载失败"
		exit
	else
		mv -f $Work_Root/dl/tmp_file $Work_Root/dl/${src_file}
	fi
fi

src_file="gtk+-bundle_2.24.10-20120208_win32.zip"
if [ ! -f $Work_Root/dl/${src_file} ]; then
	wget -t 1 http://ftp.gnome.org/mirror/gnome.org/binaries/win32/gtk+/2.24/${src_file} -O $Work_Root/dl/tmp_file
	if [ $? -ne 0 ]; then
		rm -f $Work_Root/dl/tmp_file
		echo "${src_file} 下载失败"
		exit
	else
		mv -f $Work_Root/dl/tmp_file $Work_Root/dl/${src_file}
	fi
fi

if ! ls ${Work_Root}/srcs/gtk+_inst/*; then
	mkdir -p ${Work_Root}/srcs/gtk+_inst
	for src_file in gtk+-bundle_2.24.10-20120208_win32.zip libglade_2.6.4-1_win32.zip libglade-dev_2.6.4-1_win32.zip libxml2_2.9.0-1_win32.zip libxml2-dev_2.9.0-1_win32.zip; do
		unzip -o $Work_Root/dl/${src_file} -d ${Work_Root}/srcs/gtk+_inst
	done
fi

cd ${Work_Root}/srcs/gtk-test_src
./autogen.sh
panfu_l=$(pwd | cut -d '/' -f3)
panfu_b=$(echo $panfu_l| tr 'a-z' 'A-Z')
./configure CFLAGS="" GTK_CFLAGS="-mwindows -Wl,-static -static -static-libgcc $(${Work_Root}/srcs/gtk+_inst/bin/pkg-config.exe  --cflags gtk+-2.0 | sed "s#$panfu_b:#/cygdrive/$panfu_l#g")" GTK_LIBS="$(${Work_Root}/srcs/gtk+_inst/bin/pkg-config.exe  --libs gtk+-2.0 | sed "s#$panfu_b:#/cygdrive/$panfu_l#g")" GLADE_CFLAGS="-mwindows -rdynamic -static-libgcc $((${Work_Root}/srcs/gtk+_inst/bin/pkg-config.exe  --cflags libglade-2.0;${Work_Root}/srcs/gtk+_inst/bin/pkg-config.exe  --cflags libxml-2.0;) | sed "s#$panfu_b:#/cygdrive/$panfu_l#g" | tr -d '\n')" GLADE_LIBS="$((${Work_Root}/srcs/gtk+_inst/bin/pkg-config.exe  --libs libglade-2.0;${Work_Root}/srcs/gtk+_inst/bin/pkg-config.exe  --libs libxml-2.0;) | sed "s#$panfu_b:#/cygdrive/$panfu_l#g" | tr -d '\n')"
make

