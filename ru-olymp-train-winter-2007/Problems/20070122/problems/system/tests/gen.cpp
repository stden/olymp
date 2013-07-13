#include <fstream>
#include <cstdlib>
#include <ctime>
#include <iostream>
using namespace std;

int prm[2000];
int n;

void GenPrm()
{
	int i;
	for (i = 0; i < n; i++)
	{
		prm[i] = i;
	}
	for (i = 0; i < 4 * n; i++)
	{
		int i1, i2;
		i1 = rand() % (n - 1) + 1;
		i2 = rand() % (n - 1) + 1;
		int t;
		t = prm[i1];
		prm[i1] = prm[i2];
		prm[i2] = t;
	}
}

int ld[2000], pload[2000], cst[2000], root[2000];

int main(int argc, char *argv[])
{

	int minn = atoi(argv[1]);
	int maxn = atoi(argv[2]);
	int minload = atoi(argv[3]);
	int maxload = atoi(argv[4]);
	int mincost = atoi(argv[5]);
	int maxcost = atoi(argv[6]);
	int loaddec = atoi(argv[7]);
	int costdec = atoi(argv[8]);
	srand((unsigned) atoi(argv[9]));

	n = rand() % (maxn - minn + 1) + minn;
	int i;
	cout << n << "\n";
	GenPrm();
	for (i = 0; i < n; i++)
	{
		int rt, id = prm[i];
		if (i == 0) rt = 0;
		else rt = rand() % i;
		int peakload = rand() % (maxload - minload + 1) + minload;
		
		maxload -= rand() % loaddec;
		if (maxload < 1) maxload = 1;
		if (minload > maxload) minload = maxload;

		int load = rand() % (peakload + 1);
		int cost = rand() % (maxcost - mincost + 1) + mincost;

		maxcost -= rand() % costdec;
		if (maxcost < 1) maxcost = 1;
		if (mincost > maxcost) mincost = maxcost;

		root[id] = prm[rt] + 1;
		if (i == 0) root[id] = 0;
		pload[id] = peakload;
		ld[id] = load;
		cst[id] = cost;
	}
	for (i = 0; i < n; i++)
	{
		cout << root[i] << " " << pload[i] << " " << ld[i] << " " << cst[i] << "\n";
	}

	return 0;
}