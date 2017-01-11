#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define MSG_LEN 64

int main(){
   int     result;
   int     fd[2];
   char    message[MSG_LEN];
   char    recvd_msg[MSG_LEN];

   result = pipe (fd); //Creating a pipe//fd[0] is for reading and fd[1] is for writing

   if (result < 0) {
     perror("pipe ");
     exit(1);
   }

   strncpy(message,"Linux World!! ",MSG_LEN);

   result=write(fd[1],message,strlen(message));
   if (result < 0) {
      perror("write");
      exit(2);
   }

   strncpy(message,"Understanding ",MSG_LEN);

   result=write(fd[1],message,strlen(message));
   if (result < 0) {
      perror("write");
      exit(2);
  }

  strncpy(message,"Concepts of ",MSG_LEN);

  result=write(fd[1],message,strlen(message));
  if (result < 0) {
      perror("write");
      exit(2);
 }

 strncpy(message,"Piping ", MSG_LEN);
 result=write(fd[1],message,strlen(message));

 if (result < 0) {
     perror("write");
     exit(2);
 }

 result=read (fd[0],recvd_msg,MSG_LEN);
 if (result < 0) {
      perror("read");
      exit(3);
 }

 printf("%s\n",recvd_msg);
 return 0;

}
