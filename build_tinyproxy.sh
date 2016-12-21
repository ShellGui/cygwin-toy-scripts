#!/bin/sh

PKG_NAME="tinyproxy"
DOWNLOAD_URL="https://github.com/tinyproxy/tinyproxy/archive/1.8.4.tar.gz"
SRC_FILE="tinyproxy-1.8.4.tar.gz"
SRC_FILE_MD5="78fef4073c90fe1f3b8a0cb2a2fbaee0"
SRC_DIR_NAME="tinyproxy-1.8.4"
DIST_FILES='tinyproxy.exe,cygwin1.dll'
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

. $Work_Root/http_proxy.conf

mkdir -p $Work_Root/dl

if [ ! -f $Work_Root/dl/$SRC_FILE ] || [ "$(md5sum $Work_Root/dl/$SRC_FILE | cut -d ' ' -f1)" != "${SRC_FILE_MD5}" ]; then
	wget "${DOWNLOAD_URL}" -O $Work_Root/dl/$SRC_FILE
fi


rm -rf $Work_Root/srcs/${PKG_NAME}_build
mkdir -p $Work_Root/srcs/${PKG_NAME}_build
tar zxvf $Work_Root/dl/$SRC_FILE -C $Work_Root/srcs/${PKG_NAME}_build


cd $Work_Root/srcs/${PKG_NAME}_build/${SRC_DIR_NAME}
./autogen.sh --enable-transparent --disable-regexcheck LDFLAGS="-Wl,--no-undefined -static-libgcc" # --host=i686-pc-cygwin
sed -i 's#-Wl,-z#-Wl#g' Makefile
sed -i 's#-Wl,-z#-Wl#g' src/Makefile
sed -i 's#-Wl,defs##g' Makefile
sed -i 's#-Wl,defs##g' src/Makefile
make


# 整理文件
rm -rf $Work_Root/srcs/${PKG_NAME}_build/dist/
mkdir -p $Work_Root/srcs/${PKG_NAME}_build/dist/
cp -vr $Work_Root/srcs/${PKG_NAME}_build/${SRC_DIR_NAME}/src/*.exe $Work_Root/srcs/${PKG_NAME}_build/dist/
DLLS_NEEDS=$(for file in $(find $Work_Root/srcs/${PKG_NAME}_build/dist/ -name '*.exe'); do
	objdump -p ${file} | grep "DLL Name" | grep -v 'KERNEL32.dll'
done | awk '{print $NF}' | sort -n | uniq)
for dll_file in $DLLS_NEEDS; do
	find /bin -name ${dll_file}
done | sort -n | uniq | while read file;do
	cp -vr ${file} $Work_Root/srcs/${PKG_NAME}_build/dist/
done

check_builded

# -lcrypto
# -L/usr/lib -I/usr/include
# CFLAGS="-L/usr/lib -I/usr/include"
# --disable-shared --enable-static
# -L/usr/lib -I/usr/include -lpcre
# -Wl,-static
# -L/usr/lib -lpcre
# /use/lib/libpcre.a
# objdump -p hello.exe | grep "DLL Name"
