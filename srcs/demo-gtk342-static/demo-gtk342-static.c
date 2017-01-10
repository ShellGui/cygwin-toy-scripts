#include <gtk/gtk.h>

#include <unistd.h>

static int count=1;

char c[2];

static void hello( GtkWidget *widget, gpointer   data )

{

	if (count > 0) {
		gtk_button_set_label ((GtkButton*)widget,"停止");
		count = 0;
	} else {
		gtk_button_set_label ((GtkButton*)widget,"开始");
		count++;
	}

 }

static void destroy( GtkWidget *widget, gpointer   data )

{

  gtk_main_quit ();

}

int main( int   argc,  char *argv[] )

{

  GtkWidget *window;

  GtkWidget *button;

  gtk_init (&argc, &argv);

  /* create a new window */

  window = gtk_window_new (GTK_WINDOW_TOPLEVEL);

  g_signal_connect (G_OBJECT (window), "destroy",

        G_CALLBACK (destroy), NULL);

  gtk_container_set_border_width (GTK_CONTAINER (window), 20);

  button = gtk_button_new_with_label ("开始");

  g_signal_connect (G_OBJECT (button), "clicked",

        G_CALLBACK (hello), NULL);

  gtk_container_add (GTK_CONTAINER (window), button);

  gtk_widget_show (button);

  gtk_widget_show (window);

  gtk_main ();

  return 0;

}