#!/bin/sh

PKG_NAME="gcc"
DOWNLOAD_URL="http://ftp.jaist.ac.jp/pub/GNU/gcc/gcc-4.8.4/gcc-4.8.4.tar.gz"
SRC_FILE="gcc-4.8.4.tar.gz"
SRC_FILE_MD5="0c92ac45af5b280e301ca56b40fdaea2"
SRC_DIR_NAME="gcc-4.8.4"
DIST_FILES='ss-local.exe,ss-server.exe,ss-tunnel.exe,cygwin1.dll'
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

# if [ ! -f ${Work_Root}/srcs/libpcre_cygport/pcre-8.39-1.i686/inst/usr/lib/libpcre.a ]; then
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


# rm -rf $Work_Root/srcs/${PKG_NAME}_build
# mkdir -p $Work_Root/srcs/${PKG_NAME}_build
# tar zxvf $Work_Root/dl/$SRC_FILE -C $Work_Root/srcs/${PKG_NAME}_build


cd $Work_Root/srcs/${PKG_NAME}_build/	# ${SRC_DIR_NAME}

# LIBS="-ldl " LDFLAGS="-Wl,-static -static -static-libgcc " ./configure --disable-documentation --with-pcre=${Work_Root}/srcs/libpcre_cygport/pcre-8.39-1.i686/inst/usr/  --enable-static # --host=i686-pc-cygwin
# make
mkdir build-gcc
cd build-gcc
../gcc-4.8.4/configure --program-suffix=-4.8.4 --enable-languages=c,c++ --disable-bootstrap --disable-shared --prefix=$Work_Root/srcs/gcc-inst-4.8.4 --with-gmp=$Work_Root/srcs/gcc-inst-4.8.4 --with-mpfr=$Work_Root/srcs/gcc-inst-4.8.4 --with-mpc=$Work_Root/srcs/gcc-inst-4.8.4
make -j2
make install
# 整理文件
rm -rf $Work_Root/srcs/${PKG_NAME}_build/dist/
mkdir -p $Work_Root/srcs/${PKG_NAME}_build/dist/
cp -vr $Work_Root/srcs/${PKG_NAME}_build/${SRC_DIR_NAME}/src/*.exe $Work_Root/srcs/${PKG_NAME}_build/dist/
# DLLS_NEEDS=$(for file in $(find $Work_Root/srcs/${PKG_NAME}_build/dist/ -name '*.exe'); do
	# objdump -p ${file} | grep "DLL Name" | grep -v 'KERNEL32.dll'
# done | awk '{print $NF}' | sort -n | uniq)
# for dll_file in $DLLS_NEEDS; do
	# find /bin -name ${dll_file}
# done | sort -n | uniq | while read file;do
	# cp -vr ${file} $Work_Root/srcs/${PKG_NAME}_build/dist/
# done

check_builded
