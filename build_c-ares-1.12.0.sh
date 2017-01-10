#!/bin/sh

Work_Root=$(pwd)

PKG_NAME="c-ares"
DOWNLOAD_URL="http://c-ares.haxx.se/download/c-ares-1.12.0.tar.gz"
SRC_FILE="c-ares-1.12.0.tar.gz"
SRC_FILE_MD5="2ca44be1715cd2c5666a165d35788424"
DIST_FILES="${Work_Root}/srcs/c-ares_cygport/c-ares-1.12.0-1bl1.i686/inst/usr/lib/libcares.a"
SRC_DIR_NAME="c-ares-1.12.0"

([ -z "$PKG_NAME" ] || [ -z "$DOWNLOAD_URL" ] || [ -z "$SRC_FILE" ] || [ -z "$SRC_DIR_NAME" ] || [ -z "$SRC_FILE_MD5" ] || [ -z "$DIST_FILES" ]) && exit

[ "$1" = "clean" ] && rm -rf $Work_Root/srcs/c-ares_cygport/c-ares-1.12.0-1bl1.i686 && exit


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

if [ ! -f $Work_Root/srcs/c-ares_cygport/$SRC_FILE ] && [ "$(md5sum $Work_Root/srcs/c-ares_cygport/$SRC_FILE | cut -d ' ' -f1)" != "${SRC_FILE_MD5}" ]; then
	wget "${DOWNLOAD_URL}" -O $Work_Root/srcs/c-ares_cygport/$SRC_FILE
fi


cd $Work_Root/srcs/c-ares_cygport

cygport c-ares-1.12.0-1bl1.cygport all

check_builded
