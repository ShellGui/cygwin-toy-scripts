## Process this file with automake to generate a Makefile.in
## To build all programs with GTK+ uncomment these lines.
##AM_CPPFLAGS = @GTK_CFLAGS@
##AM_LDADD = @GTK_LIBS@

bin_PROGRAMS = gui glade_test
gui_SOURCES = main.c
glade_test_SOURCES = glade-test.c

## Only our GUI program uses GTK+ at the moment.
gui_CFLAGS = $(GTK_CFLAGS)
gui_LDADD = $(GTK_LIBS)

glade_test_CFLAGS =  $(GLADE_CFLAGS)
glade_test_LDADD = $(GLADE_LIBS)

CLEANFILES = *~
