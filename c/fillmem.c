// Program to allocate 1 GB of memory
// to run:  gcc fillmem.c && ./a.out

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char *mybuffer;
char *temp;
const long GB = 1024*1024*1024;
//const long alloc = 1*1024*1024*1024;
long alloc = 1;

void fillmem();

int main(int argc, char *argv[]) {

	alloc = 2*GB;
  printf("Size is %ld bytes (%ld GB) \n", alloc, alloc/GB);
	while(1==1) {
		fillmem();
	}

	printf("Bye\n");
	return 0;
}

void fillmem() {
   printf("Allocating mem..\n");
   mybuffer = malloc(alloc);
   temp = memset(mybuffer,0,(alloc));
   sleep(3);
   printf("Free mem..\n");
   free(mybuffer);
   sleep(3);
}
