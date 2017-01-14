#!/bin/sh

# http://mirrors.sohu.com/cygwin/
# ftp://ftp.sjtu.edu.cn/sites/cygwin.com/pub/cygwin/
# http://ftp.jaist.ac.jp/pub/cygwin/

Work_Root=$(pwd)

if uname -s | grep -q 'NT-5.1'; then
	echo "$Work_Root/CygwinXP/cygwinxp.local" > ~/.cygwinxp.local.path
else
cache=$(awk '
BEGIN {
RS = "\n\\<"
FS = "\n\t"
}
$1 == "last-cache" {
print $2
}
' /etc/setup/setup.rc)

mirror=$(awk '
/last-mirror/ {
getline
print $1
}
' /etc/setup/setup.rc)
mirrordir=$(sed '
s / %2f g
s : %3a g
' <<< "$mirror")

mkdir -p "$cache/$mirrordir/$arch"
cd "$cache/$mirrordir/$arch"
rm -rf setup.bz2
fi

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

libev-devel

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

# gtk pkgs

xinit



libgtk3-devel
libgtk3-doc
libgailutil3_0
libgailutil3-devel
libgailutil3-doc
girepository-Gtk3.0
gtk3-demo
gtk-update-icon-cache

libiconv
# libintl
zlib
libpng12
# libjpeg
tiff
# XFree86-bin

p7zip

# gobject
# gmodule
# glib
# atk
# pango
# pangowin32
# gdk-win32
# gdk_pixbuf
# gtk

# libsigc+
# gtkmm

mingw64-i686-gcc-core
mingw64-i686-gcc-g++
mingw64-i686-runtime
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

# if ! which apt-cyg &>/dev/null; then
install ${Work_Root}/bin/apt-cyg /usr/bin
# fi
# apt-cyg mirror http://ftp.jaist.ac.jp/pub/cygwin/
# apt-cyg update
apt-cyg install $(echo "$base_pkgs" | grep -v '#' | tr '\n' ' ') 

# apt-cyg update
# apt-cyg listfiles libisl10
# apt-cyg searchall advapi
