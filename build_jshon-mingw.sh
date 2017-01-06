#!/bin/sh

PKG_NAME="jshon"
DOWNLOAD_URL="https://github.com/keenerd/jshon/raw/master/jshon.c"
SRC_FILE="jshon.c"
SRC_FILE_MD5="null"
SRC_DIR_NAME="jshon-master"
DIST_FILES='jshon.exe'
([ -z "$PKG_NAME" ] || [ -z "$DOWNLOAD_URL" ] || [ -z "$SRC_FILE" ] || [ -z "$SRC_DIR_NAME" ] || [ -z "$SRC_FILE_MD5" ] || [ -z "$DIST_FILES" ]) && exit


Work_Root=$(pwd)

[ "$1" = "clean" ] && rm -rf $Work_Root/srcs/${PKG_NAME}_build && exit

check_builded() {
for file in $(echo "$DIST_FILES" | tr ',' '\n'); do
	if [ ! -f $Work_Root/srcs/${PKG_NAME}_build/dist/${file} ]; then
	cat <<EOF
Build fails with ${file} no esixt!
EOF
	return 1
	else
	cat <<EOF
${file} esixt.
EOF
	fi
done
return 0
}

if check_builded; then
	cat <<EOF

run: $0 clean
EOF
exit
fi

if [ ! -f ${Work_Root}/srcs/jansson_build/dist/usr/lib/libjansson.a ]; then
	cat <<EOF
Please Build libpcre first:
./build_jansson-2.9-mingw.sh
EOF
exit
fi

. $Work_Root/http_proxy.conf

mkdir -p $Work_Root/dl

if [ ! -f $Work_Root/dl/$SRC_FILE ]; then
	wget "${DOWNLOAD_URL}" -O $Work_Root/dl/$SRC_FILE
fi

rm -rf $Work_Root/srcs/${PKG_NAME}_build
mkdir -p $Work_Root/srcs/${PKG_NAME}_build/jshon-master
cp -v $Work_Root/dl/$SRC_FILE $Work_Root/srcs/${PKG_NAME}_build/jshon-master


cd $Work_Root/srcs/${PKG_NAME}_build/${SRC_DIR_NAME}
cat <<EOF
i686-w64-mingw32-gcc --verbose -Wl,-static -static -static-libgcc -I$Work_Root/srcs/jansson_build/dist/usr/include -L$Work_Root/srcs/jansson_build/dist/usr/lib jshon.c -ljansson -o jshon
EOF
i686-w64-mingw32-gcc --verbose -Wl,-static -static -static-libgcc -I$Work_Root/srcs/jansson_build/dist/usr/include -L$Work_Root/srcs/jansson_build/dist/usr/lib jshon.c -ljansson -o jshon

# 整理文件
rm -rf $Work_Root/srcs/${PKG_NAME}_build/dist/
mkdir -p $Work_Root/srcs/${PKG_NAME}_build/dist/
cp -vr $Work_Root/srcs/${PKG_NAME}_build/${SRC_DIR_NAME}/*.exe $Work_Root/srcs/${PKG_NAME}_build/dist/

check_builded
if check_builded; then
	cp -vr $Work_Root/srcs/${PKG_NAME}_build/${SRC_DIR_NAME}/*.exe $Work_Root/dist/jshon
fi
