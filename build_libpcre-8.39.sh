#!/bin/sh

Work_Root=$(pwd)

PKG_NAME="pcre"
DOWNLOAD_URL="http://ftp.cs.stanford.edu/pub/exim/pcre/pcre-8.39.tar.bz2"
SRC_FILE="pcre-8.39.tar.bz2"
SRC_FILE_MD5="e3fca7650a0556a2647821679d81f585"
DIST_FILES="${Work_Root}/srcs/libpcre_cygport/pcre-8.39-1.i686/inst/usr/lib/libpcre.a"
SRC_DIR_NAME="pcre-8.39"

([ -z "$PKG_NAME" ] || [ -z "$DOWNLOAD_URL" ] || [ -z "$SRC_FILE" ] || [ -z "$SRC_DIR_NAME" ] || [ -z "$SRC_FILE_MD5" ] || [ -z "$DIST_FILES" ]) && exit

[ "$1" = "clean" ] && rm -rf $Work_Root/srcs/libpcre_cygport/pcre-8.39-1.i686 && exit


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

if [ ! -f $Work_Root/srcs/libpcre_cygport/$SRC_FILE ] && [ "$(md5sum $Work_Root/srcs/libpcre_cygport/$SRC_FILE | cut -d ' ' -f1)" != "${SRC_FILE_MD5}" ]; then
	wget "${DOWNLOAD_URL}" -O $Work_Root/srcs/libpcre_cygport/$SRC_FILE
fi


cd $Work_Root/srcs/libpcre_cygport

cygport pcre.cygport all

check_builded
