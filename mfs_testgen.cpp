#include <cstdio>
#include <cstdlib>
#include <ctime>

#define MAXNODE 50
#define MINNODE 2

#define MAXDIST 1000
#define MINDIST 0

int main()
{
	timespec t;
	clock_gettime(CLOCK_REALTIME, &t);
	srand(t.tv_sec ^ t.tv_nsec);
	
	//int n = (rand() % (MAXNODE-MINNODE))+MINNODE;
	//int e = rand() % (n*n);
	int n = 1000;
	int e = 10000;
	int source = rand() % n;
	int sink = rand() % (n-1);
	if (sink >= source)
		sink++;
	//int n = 10000;
	//int e = 100000;
	//int s = 0;
	
	printf("%d %d %d %d\n", n, e, source, sink);
	for (int i=0; i<e; i++)
	{
		printf("%d %d %d %d\n", rand()%n, rand() % n, 0, (rand() % (MAXDIST-MINDIST))+MINDIST);
	}
	
	return 0;
}
