#!/bin/sh

PKG_NAME="masscan"
DOWNLOAD_URL="https://github.com/robertdavidgraham/masscan/archive/1.0.3.tar.gz"
SRC_FILE="masscan-1.0.3.tar.gz"
SRC_FILE_MD5="ca88d1ec4b58dd165dbc0d66dbf026c5"
SRC_DIR_NAME="masscan-1.0.3"
DIST_FILES='masscan.exe'
([ -z "$PKG_NAME" ] || [ -z "$DOWNLOAD_URL" ] || [ -z "$SRC_FILE" ] || [ -z "$SRC_DIR_NAME" ] || [ -z "$SRC_FILE_MD5" ] || [ -z "$DIST_FILES" ]) && exit


Work_Root=$(pwd)

[ "$1" = "clean" ] && rm -rf $Work_Root/srcs/${PKG_NAME}_build/${SRC_DIR_NAME} $Work_Root/srcs/${PKG_NAME}_build/dist && exit

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

. $Work_Root/http_proxy.conf

mkdir -p $Work_Root/dl

if [ ! -f $Work_Root/dl/$SRC_FILE ] || [ "$(md5sum $Work_Root/dl/$SRC_FILE | cut -d ' ' -f1)" != "${SRC_FILE_MD5}" ]; then
	wget "${DOWNLOAD_URL}" -O $Work_Root/dl/$SRC_FILE
fi


rm -rf $Work_Root/srcs/${PKG_NAME}_build/${SRC_DIR_NAME} $Work_Root/srcs/${PKG_NAME}_build/dist
# mkdir -p $Work_Root/srcs/${PKG_NAME}_build
tar zxvf $Work_Root/dl/$SRC_FILE -C $Work_Root/srcs/${PKG_NAME}_build

cd $Work_Root/srcs/${PKG_NAME}_build/${SRC_DIR_NAME}
patch -p1 < ../masscan-1.0.3-mingw.patch
make


# 整理文件
rm -rf $Work_Root/srcs/${PKG_NAME}_build/dist/
mkdir -p $Work_Root/srcs/${PKG_NAME}_build/dist/
cp -vr $Work_Root/srcs/${PKG_NAME}_build/${SRC_DIR_NAME}/bin/*.exe $Work_Root/srcs/${PKG_NAME}_build/dist/

if check_builded; then
	cp -vr $Work_Root/srcs/${PKG_NAME}_build/${SRC_DIR_NAME}/bin/*.exe $Work_Root/dist/${PKG_NAME}
fi
