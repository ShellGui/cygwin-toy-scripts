#!/bin/sh

PKG_NAME="jansson"
DOWNLOAD_URL="http://www.digip.org/jansson/releases/jansson-2.9.tar.gz"
SRC_FILE="jansson-2.9.tar.gz"
SRC_FILE_MD5="84abaefee9502b2f2ff394d758f160c7"
SRC_DIR_NAME="jansson-2.9"
DIST_FILES='usr/lib/libjansson.a'
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

# if [ ! -f ${Work_Root}s/libpcre_cygport/pcre-8.39-1.i686/inst/usr/lib/libpcre.a ]; then
	# cat <<EOF
# Please Build libpcre first:
# ./build_libpcre-8.39.sh
# EOF
# exit
# fi

. $Work_Root/http_proxy.conf

mkdir -p $Work_Root/dl

if [ ! -f $Work_Root/dl/$SRC_FILE ] || [ "$(md5sum $Work_Root/dl/$SRC_FILE | cut -d ' ' -f1)" != "${SRC_FILE_MD5}" ]; then
	wget "${DOWNLOAD_URL}" -O $Work_Root/dl/$SRC_FILE
fi

rm -rf $Work_Root/srcs/${PKG_NAME}_build
mkdir -p $Work_Root/srcs/${PKG_NAME}_build
tar zxvf $Work_Root/dl/$SRC_FILE -C $Work_Root/srcs/${PKG_NAME}_build


cd $Work_Root/srcs/${PKG_NAME}_build/${SRC_DIR_NAME}
LIBS="" LDFLAGS="-Wl,-static -static -static-libgcc " ./configure --prefix=/usr --target=i686-w64-mingw32 --host=i686-w64-mingw32
make
make install DESTDIR=$Work_Root/srcs/${PKG_NAME}_build/dist/

check_builded
