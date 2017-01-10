#!/bin/sh

Work_Root=$(pwd)

PKG_NAME="mosquitto"
DOWNLOAD_URL="https://github.com/eclipse/mosquitto/archive/v1.4.10.tar.gz"
SRC_FILE="mosquitto-1.4.10.tar.gz"
SRC_FILE_MD5="35265cbb7cbc16445f468de599fb5ad6"
DIST_FILES="${Work_Root}/srcs/mosquitto_cygport/mosquitto-1.4.10-1bl1.i686/dist/usr/lib/libmosquitto.a"
SRC_DIR_NAME="mosquitto-1.4.10"

([ -z "$PKG_NAME" ] || [ -z "$DOWNLOAD_URL" ] || [ -z "$SRC_FILE" ] || [ -z "$SRC_DIR_NAME" ] || [ -z "$SRC_FILE_MD5" ] || [ -z "$DIST_FILES" ]) && exit

[ "$1" = "clean" ] && rm -rf $Work_Root/srcs/mosquitto_cygport/mosquitto-1.4.10-1bl1.i686 && exit


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

if [ ! -f ${Work_Root}/srcs/openssl_cygport/openssl-1.0.2e-1.i686/inst/usr/lib/libssl.a ]; then
	cat <<EOF
Please Build libpcre first:
./build_openssl.sh
EOF
exit
fi
if [ ! -f ${Work_Root}/srcs/c-ares_cygport/c-ares-1.12.0-1bl1.i686/inst/usr/lib/libcares.a ]; then
	cat <<EOF
Please Build libpcre first:
./build_c-ares-1.12.0.sh
EOF
exit
fi

. $Work_Root/http_proxy.conf

if [ ! -f $Work_Root/srcs/mosquitto_cygport/$SRC_FILE ] && [ "$(md5sum $Work_Root/srcs/mosquitto_cygport/$SRC_FILE | cut -d ' ' -f1)" != "${SRC_FILE_MD5}" ]; then
	wget "${DOWNLOAD_URL}" -O $Work_Root/srcs/mosquitto_cygport/$SRC_FILE
fi

cd $Work_Root/srcs/mosquitto_cygport
sed "s#PPPWWWDDD#$Work_Root#g" ${Work_Root}/srcs/mosquitto_cygport/mosquitto-1.4.10-1bl1.src.patch.temp > ${Work_Root}/srcs/mosquitto_cygport/mosquitto-1.4.10-1bl1.src.patch
cygport mosquitto-1.4.10-1bl1.cygport all
mkdir -p ${Work_Root}/srcs/mosquitto_cygport/mosquitto-1.4.10-1bl1.i686/dist/usr/lib
mkdir -p ${Work_Root}/srcs/mosquitto_cygport/mosquitto-1.4.10-1bl1.i686/dist/usr/include
cp -vr ${Work_Root}/srcs/mosquitto_cygport/mosquitto-1.4.10-1bl1.i686/build/lib/cpp/libmosquittopp.a ${Work_Root}/srcs/mosquitto_cygport/mosquitto-1.4.10-1bl1.i686/dist/usr/lib
cp -vr ${Work_Root}/srcs/mosquitto_cygport/mosquitto-1.4.10-1bl1.i686/build/lib/libmosquitto.a ${Work_Root}/srcs/mosquitto_cygport/mosquitto-1.4.10-1bl1.i686/dist/usr/lib
cp -vr ${Work_Root}/srcs/mosquitto_cygport/mosquitto-1.4.10-1bl1.i686/src/mosquitto-1.4.10/lib/mosquitto.h  ${Work_Root}/srcs/mosquitto_cygport/mosquitto-1.4.10-1bl1.i686/dist/usr/include/mosquitto.h 
check_builded

# gcc -ldl -Wl,-static -static -static-libgcc ${Work_Root}/srcs/mosquitto_cygport/mosquitto-1.4.10-1bl1.i686/src/mosquitto-1.4.10/test/lib/c/02-subscribe-qos0.c -o ${Work_Root}/xx.exe -I${Work_Root}/srcs/mosquitto_cygport/mosquitto-1.4.10-1bl1.i686/src/mosquitto-1.4.10/lib -L${Work_Root}/srcs/mosquitto_cygport/mosquitto-1.4.10-1bl1.i686/build/lib -I${Work_Root}/srcs/openssl_cygport/openssl-1.0.2e-1.i686/inst/usr/include -L${Work_Root}/srcs/openssl_cygport/openssl-1.0.2e-1.i686/inst/usr/lib -I${Work_Root}/srcs/c-ares_cygport/c-ares-1.12.0-1bl1.i686/inst/usr/include -L${Work_Root}/srcs/c-ares_cygport/c-ares-1.12.0-1bl1.i686/inst/usr/lib -lmosquitto -lrt -lssl -lcrypto -ldl -lz -lcares
