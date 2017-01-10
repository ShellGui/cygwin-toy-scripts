#!/bin/sh

Work_Root=$(pwd)
panfu_l=$(pwd | cut -d '/' -f3)
panfu_b=$(echo $panfu_l| tr 'a-z' 'A-Z')
Work_root_mingw=$panfu_b":/"$(pwd | cut -d '/' -f4-)
Work_root_mingw_gtk=$(echo "$Work_root_mingw/srcs/gtk342-static/gtk342/gtk342_static")

CHROOT="$Work_Root/srcs/gcc-4.8.2-mingw/mingw32"
MINGW="$CHROOT"

LIBRARY_PATH="$CHROOT/lib" \
LDFLAGS="-L$MINGW/lib" \
CFLAGS="-I$MINGW/include -Wno-poison-system-directories" \
CXXFLAGS="-I$MINGW/include -Wno-poison-system-directories" \
CPPFLAGS="-I$MINGW/include -Wno-poison-system-directories" \
CC="i686-w64-mingw32-gcc" CXX="i686-w64-mingw32-g++" \
CC_FOR_TARGET="i686-w64-mingw32-gcc" CXX_FOR_TARGET="i686-w64-mingw32-g++" \
$Work_Root/srcs/gcc-4.8.2-mingw/mingw32/bin/i686-w64-mingw32-gcc $Work_root_mingw/srcs/demo-gtk342-static/demo-gtk342-static.c -o $Work_root_mingw/srcs/demo-gtk342-static/demo-gtk342-static -O2 -Wl,-static -static -static-libgcc -I$Work_root_mingw_gtk/include/gtk-3.0 -I$Work_root_mingw_gtk/include/glib-2.0 -I$Work_root_mingw_gtk/lib/glib-2.0/include -I$Work_root_mingw_gtk/lib/libffi-3.0.10/include -I$Work_root_mingw_gtk/include/gdk-pixbuf-2.0 -I$Work_root_mingw_gtk/include/pango-1.0 -I$Work_root_mingw_gtk/include/cairo -I$Work_root_mingw_gtk/include/atk-1.0  -L$Work_root_mingw_gtk/lib -lgtk-3 -lgdk-3 -lgdk_pixbuf-2.0 -lgobject-2.0 -lglib-2.0 -lpango-1.0 -latk-1.0 -lcairo -lcairo-gobject -lpangocairo-1.0 -lintl -lgmodule-2.0 -lgio-2.0 -limm32 -luser32 -lgdi32 -luuid -lole32 -lpng -lgdiplus -lpangowin32-1.0 -lffi -lws2_32 -lwinmm -lglib-2.0 -lpixman-1 -lfreetype -lfontconfig -lpangoft2-1.0 -lmsimg32 -liconv -lshlwapi -lz -lgdi32 -ldnsapi -lusp10 -lfreetype -lexpat -lgcc -lkernel32 -lmsvcrt
