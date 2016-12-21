#!/bin/sh

Work_Root=$(pwd)

PKG_NAME="ChinaDNS"
DOWNLOAD_URL="https://github.com/shadowsocks/ChinaDNS/releases/download/1.3.2/chinadns-1.3.2.tar.gz"
SRC_FILE="1.3.2.tar.gz"
SRC_FILE_MD5="285957df58a3522ee9d06f09838e2bb8"
DIST_FILES="${Work_Root}/srcs/ChinaDNS_cygport/ChinaDNS-1.3.2-1bl1.i686/inst/usr/bin/chinadns.exe"
SRC_DIR_NAME="ChinaDNS-1.3.2"

([ -z "$PKG_NAME" ] || [ -z "$DOWNLOAD_URL" ] || [ -z "$SRC_FILE" ] || [ -z "$SRC_DIR_NAME" ] || [ -z "$SRC_FILE_MD5" ] || [ -z "$DIST_FILES" ]) && exit

[ "$1" = "clean" ] && rm -rf $Work_Root/srcs/ChinaDNS_cygport/ChinaDNS-1.3.2-1bl1.i686 && exit


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

if [ ! -f $Work_Root/srcs/ChinaDNS_cygport/$SRC_FILE ] && [ "$(md5sum $Work_Root/srcs/ChinaDNS_cygport/$SRC_FILE | cut -d ' ' -f1)" != "${SRC_FILE_MD5}" ]; then
	wget "${DOWNLOAD_URL}" -O $Work_Root/srcs/ChinaDNS_cygport/$SRC_FILE
fi


cd $Work_Root/srcs/ChinaDNS_cygport

cygport ChinaDNS-1.3.2-1bl1.cygport all

check_builded
