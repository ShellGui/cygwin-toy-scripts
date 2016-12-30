AC_INIT([shellgui],[1.2.1],[417@xmlad.com])
AM_CONFIG_HEADER(config.h)
AC_CONFIG_AUX_DIR(config)
AC_PROG_CC_C99
AC_LANG_C

LT_PREREQ([2.2])
AM_PROG_LIBTOOL
AC_LTDL_DLLIB
AC_SUBST(LIBTOOL_DEPS)
LT_INIT([dlopen])
AC_SUBST(BUILDROOT)

AC_HEADER_STDBOOL
# we use Semantic Versioning x.y.z tag for release, docs: http://semver.org/
AM_INIT_AUTOMAKE


AM_MAINTAINER_MODE

AC_PROG_INSTALL

AC_ENABLE_SHARED
AC_LIBTOOL_DLOPEN
AM_PROG_LIBTOOL

# AC_ISC_POSIX
AC_C_BIGENDIAN
AC_PROG_MAKE_SET
AC_HEADER_STDC

# check for pthread
AC_CHECK_HEADER(pthread.h, , AC_MSG_ERROR(You need the pthread headers) )
AC_CHECK_LIB(pthread, pthread_create, , AC_MSG_ERROR(You need the pthread library) )

AC_CHECK_HEADER(math.h, , AC_MSG_ERROR(You need the math headers) )
AC_CHECK_LIB(m, floor, , AC_MSG_ERROR(You need the m library) )

AC_CHECK_HEADERS(string.h strings.h stdarg.h unistd.h)
AC_HAVE_LIBRARY(socket)
AC_HAVE_LIBRARY(nsl)

AC_ARG_VAR([GTK_CFLAGS], [ GTK_CFLAGS= ])
AC_ARG_VAR([GTK_LIBS], [ GTK_LIBS= ])
AC_ARG_VAR([GLADE_CFLAGS], [ GLADE_CFLAGS= ])
AC_ARG_VAR([GLADE_LIBS], [ GLADE_LIBS= ])

AC_SUBST(AM_CFLAGS)

AC_OUTPUT( 		Makefile 
			src/Makefile
			)
