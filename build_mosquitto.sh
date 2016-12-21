#!/bin/sh

Work_Root=$(pwd)

PKG_NAME="mosquitto"
DOWNLOAD_URL="https://mosquitto.org/files/source/mosquitto-1.4.8.tar.gz"
SRC_FILE="mosquitto-1.4.8.tar.gz"
SRC_FILE_MD5="d859cd474ffa61a6197bdabe007b9027"
DIST_FILES="${Work_Root}/srcs/mosquitto_cygport/mosquitto-1.4.8-1bl1.i686/inst/usr/sbin/mosquitto.exe"
SRC_DIR_NAME="mosquitto-1.4.8"

([ -z "$PKG_NAME" ] || [ -z "$DOWNLOAD_URL" ] || [ -z "$SRC_FILE" ] || [ -z "$SRC_DIR_NAME" ] || [ -z "$SRC_FILE_MD5" ] || [ -z "$DIST_FILES" ]) && exit

[ "$1" = "clean" ] && rm -rf $Work_Root/srcs/mosquitto_cygport/mosquitto-1.4.8-1bl1.i686 && exit


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

if [ ! -f $Work_Root/srcs/mosquitto_cygport/$SRC_FILE ] && [ "$(md5sum $Work_Root/srcs/mosquitto_cygport/$SRC_FILE | cut -d ' ' -f1)" != "${SRC_FILE_MD5}" ]; then
	wget "${DOWNLOAD_URL}" -O $Work_Root/srcs/mosquitto_cygport/$SRC_FILE
fi


cd $Work_Root/srcs/mosquitto_cygport

cygport mosquitto-1.4.8-1bl1.cygport all

if check_builded; then
	cp -vr ${Work_Root}/srcs/mosquitto_cygport/mosquitto-1.4.8-1bl1.i686/inst/usr/sbin/mosquitto.exe $Work_Root/dist/mosquitto
fi
