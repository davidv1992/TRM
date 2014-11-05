#include <cstdio>
#include <cstdlib>
#include <ctime>

#define MAXNODE 100
#define MINNODE 2

#define MAXCLAUSE	1000
#define MINCLAUSE	10

int main()
{
	timespec t;
	clock_gettime(CLOCK_REALTIME, &t);
	srand(t.tv_sec ^ t.tv_nsec);
	
	int n = (rand() % (MAXNODE-MINNODE))+MINNODE;
	int c = (rand() % (MAXCLAUSE-MINCLAUSE))+MINCLAUSE;
	//int n = 10000;
	//int e = 100000;
	//int s = 0;
	
	printf("%d %d\n", n, c);
	for (int i=0; i<c; i++)
	{
		int a = rand() % n;
		int b = rand() % n;
		a++;
		b++;
		if (rand()%2)
			a = -a;
		if (rand()%2)
			b = -b;
		printf("%d %d\n", a,b);
	}
	
	return 0;
}
