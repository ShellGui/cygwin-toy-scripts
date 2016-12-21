#!/bin/sh

Work_Root=$(pwd)

PKG_NAME="openssl"
DOWNLOAD_URL="http://ftp.vim.org/security/openssl/openssl-1.0.2e.tar.gz"
SRC_FILE="openssl-1.0.2e.tar.gz"
SRC_FILE_MD5="5262bfa25b60ed9de9f28d5d52d77fc5"
DIST_FILES="${Work_Root}/srcs/openssl_cygport/openssl-1.0.2e-1.i686/inst/usr/bin/openssl.exe"
SRC_DIR_NAME="openssl-1.0.2e"

([ -z "$PKG_NAME" ] || [ -z "$DOWNLOAD_URL" ] || [ -z "$SRC_FILE" ] || [ -z "$SRC_DIR_NAME" ] || [ -z "$SRC_FILE_MD5" ] || [ -z "$DIST_FILES" ]) && exit

[ "$1" = "clean" ] && rm -rf $Work_Root/srcs/openssl_cygport/openssl-1.0.2e-1.i686 && exit


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

if [ ! -f $Work_Root/srcs/openssl_cygport/$SRC_FILE ] && [ "$(md5sum $Work_Root/srcs/openssl_cygport/$SRC_FILE | cut -d ' ' -f1)" != "${SRC_FILE_MD5}" ]; then
	wget "${DOWNLOAD_URL}" -O $Work_Root/srcs/openssl_cygport/$SRC_FILE
fi


cd $Work_Root/srcs/openssl_cygport

cygport openssl.cygport all

check_builded
