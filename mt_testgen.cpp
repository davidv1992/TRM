#include <cstdio>
#include <cstdlib>
#include <ctime>

#define MAXNODE 100
#define MINNODE 2

#define MAXDIST 1000
#define MINDIST 0

int main()
{
	timespec t;
	clock_gettime(CLOCK_REALTIME, &t);
	srand(t.tv_sec ^ t.tv_nsec);
	
	int n = (rand() % (MAXNODE-MINNODE))+MINNODE;
	int e = rand() % (n*n-(n-1)) + n-1;
	//int n = 10000;
	//int e = 100000;
	
	printf("%d %d\n", n, e);
	for (int i=1; i<n; i++)
	{
		printf("0 %d %d\n", i, (rand() % (MAXDIST-MINDIST))+MINDIST);
	}
	for (int i=0; i<e-n+1; i++)
	{
		printf("%d %d %d\n", rand()%n, rand() % n, (rand() % (MAXDIST-MINDIST))+MINDIST);
	}
	
	return 0;
}
