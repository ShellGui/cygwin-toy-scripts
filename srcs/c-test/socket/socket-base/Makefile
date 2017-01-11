CC = gcc
all:
	$(CC) create-socket.c -o create-socket
	$(CC) Connect-socket-to-a-server.c -o Connect-socket-to-a-server
	$(CC) Send-data-over-socket.c -o Send-data-over-socket
	$(CC) Receive-data-on-socket.c -o Receive-data-on-socket
	$(CC) Accept-connection.c -o Accept-connection
	$(CC) write-incoming-connection.c -o write-incoming-connection
	$(CC) Live-Server.c -o Live-Server
	$(CC) Handle-multiple-socket-connections-with-threads.c -o Handle-multiple-socket-connections-with-threads -lpthread
clean:
	rm -rf *.exe
