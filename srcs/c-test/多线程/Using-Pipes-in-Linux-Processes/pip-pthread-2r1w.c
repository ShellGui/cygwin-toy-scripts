#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>

int fd_reader1[2];// 用于 pipe 的文件描述符
int fd_reader2[2];// 用于 pipe 的文件描述符

//This function 一直 读 fd[0] for any input data byte
//If available, prints

void *reader1()
{
	while(1){
		char    ch;
		int     result;

		result = read (fd_reader1[0],&ch,1);
		if (result != 1) {
			perror("read");
			exit(3);
		}

		printf ("Reader1: %c\n", ch);
	}
}
void *reader2()
{
	while(1){
		char    ch;
		int     result;

		result = read (fd_reader2[0],&ch,1);
		if (result != 1) {
			perror("read");
			exit(3);
		}

		printf ("Reader2: %c\n", ch);
	}
}

//This function 一直 写 Alphabet into fd[1]
//Waits if no more space is available

int writer_action(int fd_reader, char input)
{
	int rc;
	rc = write (fd_reader, &input,1);
	return rc;
}

void *writer()
{
	char    ch='A';

	while(1){

		if (writer_action(fd_reader1[1], ch) != 1) {
			perror ("write fd_reader1");
			exit (2);
		}

		if (writer_action(fd_reader2[1], ch) != 1) {
			perror ("write fd_reader2");
			exit (2);
		}

	printf ("Writer: %c\n", ch);
	if(ch == 'Z')
		ch = 'A'-1;

		ch++;
		sleep(1);
	}
}

int main()
{
	pthread_t       tid1,tid2,tid3;
	int             result;

	result = pipe (fd_reader1);
	if (result < 0) {
		perror("pipe reader1");
		exit(1);
	}

	result = pipe (fd_reader2);
	if (result < 0) {
		perror("pipe reader2");
		exit(1);
	}

	pthread_create(&tid1,NULL,reader1,NULL);
	pthread_create(&tid2,NULL,reader2,NULL);
	pthread_create(&tid3,NULL,writer,NULL);

	pthread_join(tid1,NULL);
	pthread_join(tid2,NULL);
	pthread_join(tid3,NULL);
}
