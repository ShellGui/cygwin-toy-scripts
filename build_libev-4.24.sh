#!/bin/sh

Work_Root=$(pwd)

PKG_NAME="libev"
DOWNLOAD_URL="http://dist.schmorp.de/libev/Attic/libev-4.20.tar.gz"
SRC_FILE="libev-4.20.tar.gz"
SRC_FILE_MD5="1cac539cfc560f381a490c9fba940de9"
DIST_FILES="${Work_Root}/srcs/libev_cygport/libev-4.20-1bl1.i686/inst/usr/lib/libev.dll.a"
SRC_DIR_NAME="libev-4.20"

([ -z "$PKG_NAME" ] || [ -z "$DOWNLOAD_URL" ] || [ -z "$SRC_FILE" ] || [ -z "$SRC_DIR_NAME" ] || [ -z "$SRC_FILE_MD5" ] || [ -z "$DIST_FILES" ]) && exit

[ "$1" = "clean" ] && rm -rf $Work_Root/srcs/libev_cygport/libev-4.20-1bl1.i686 && exit


check_builded() {
if [ ! -f $DIST_FILES ]; then
	cat <<EOF
Build fails with ${DIST_FILES} no esixt!
EOF
	return 1
	else
	cat <<EOF
${DIST_FILES} esixt
EOF
	return 0
fi
}

if check_builded; then
	cat <<EOF

run: $0 clean
EOF
exit
fi

. $Work_Root/http_proxy.conf

if [ ! -f $Work_Root/srcs/libev_cygport/$SRC_FILE ] && [ "$(md5sum $Work_Root/srcs/libev_cygport/$SRC_FILE | cut -d ' ' -f1)" != "${SRC_FILE_MD5}" ]; then
	wget "${DOWNLOAD_URL}" -O $Work_Root/srcs/libev_cygport/$SRC_FILE
fi


cd $Work_Root/srcs/libev_cygport

cygport libev-4.20-1bl1.cygport all

check_builded
