#include <gtk/gtk.h>
#include <glade/glade.h>

void close(GtkWidget *window, gpointer data)
{
gtk_main_quit();
}

int main(int argc, char* argv[])
{
GladeXML *gxml;
GtkWidget *window;

gtk_init(&argc,&argv);
gxml=glade_xml_new("glade-test.glade",NULL,NULL);
window=glade_xml_get_widget(gxml,"window");

g_object_unref(G_OBJECT(gxml));
g_signal_connect(GTK_OBJECT(window),"destroy",GTK_SIGNAL_FUNC(close),NULL);

gtk_widget_show(window);
gtk_main();

return 0;
}