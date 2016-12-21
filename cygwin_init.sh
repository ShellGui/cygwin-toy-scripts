#!/bin/sh

# http://mirrors.sohu.com/cygwin/
# ftp://ftp.sjtu.edu.cn/sites/cygwin.com/pub/cygwin/
# http://ftp.jaist.ac.jp/pub/cygwin/

Work_Root=$(pwd)

. $Work_Root/http_proxy.conf


base_pkgs="
binutils
cmake
dos2unix
gawk
gcc-core
gdb
gcc-g++
w32api-runtime
openssl-devel
libpcre-devel
zlib-devel
libmpc3
libisl10 libisl13
git
groff
help2man
pkg-config
robodoc
sed
xz
autoconf
automake
make
cygport
libevent-devel
asciidoc
libexpat-devel
libbz2-devel
libreadline-devel
libarchive13

libwrap-devel
# tcp_wrappers

# autoconf (wrapper) and autoconf2.*
# automake (wrapper) and automake1.*
bash
binutils
bzip2
coreutils
diffstat
diffutils
dos2unix
file
gawk
grep
gzip
lftp
libtool
lndir
make
openssh
patch
rsync
sed
tar
unzip
util-linux
wget
which
xz
"
# libusb-win32-devel-filter-1.2.6.0.exe

for cmd in wget tar gawk bzip2; do
if ! which ${cmd} &>/dev/null; then
cat <<EOF
Please install below at first:
wget tar gawk bzip2
EOF
fi
done

if ! which apt-cyg &>/dev/null; then
install ./bin/apt-cyg /usr/bin
fi
apt-cyg mirror http://ftp.jaist.ac.jp/pub/cygwin/
apt-cyg update
apt-cyg install $(echo "$base_pkgs" | grep -v '#' | tr '\n' ' ') 

# apt-cyg update
# apt-cyg listfiles libisl10
# apt-cyg searchall advapi
