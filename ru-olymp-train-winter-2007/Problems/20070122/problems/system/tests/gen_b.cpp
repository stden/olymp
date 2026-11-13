#include <fstream>
#include <cstdlib>
#include <ctime>
#include <iostream>
using namespace std;

int prm[2000];
int n;

int GetRandom()
{
	int a = rand();
	a *= a;
	if (a < 0) a = -a;
	return a;
}

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

const int INNERMAX = 100;
const int INNERUP = 40;
const int MAXINC = 50, MININC = 5;
const int LEAFCOST = 10;

int minn, maxn, minload, maxload, mincost, maxcost, loaddec, costdec;

int ld[2000], pload[2000], cst[2000], root[2000];

void IncreaseCost(int ver)
{
	int add = rand() % (MAXINC - MININC + 1) + MININC;
	cst[ver] += add;
	if (cst[ver] > maxcost) cst[ver] = maxcost;
}

int main(int argc, char *argv[])
{

	minn = atoi(argv[1]);
	maxn = atoi(argv[2]);
	minload = atoi(argv[3]);
	maxload = atoi(argv[4]);
	mincost = atoi(argv[5]);
	maxcost = atoi(argv[6]);
	loaddec = atoi(argv[7]);
	costdec = atoi(argv[8]);
	srand((unsigned) atoi(argv[9]));

	n = rand() % (maxn - minn + 1) + minn;
	int i;
	cout << n << "\n";
	GenPrm();
	int lastinner = 1;
	for (i = 0; i < n; i++)
	{
		int rt, id = prm[i];
		if (i == 0) rt = 0;
		else 
		{
			rt = GetRandom() % lastinner;
			if (rand() % INNERMAX <= INNERUP) lastinner++;
		}
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
	int isleaf[2001];
	memset(isleaf, 0, sizeof(isleaf));
	for (i = 1; i < n; i++) isleaf[root[i]] = 1;
	int numleafs = 0;
	for (i = 1; i < n; i++)
	{
		if (isleaf[i] == 0) numleafs++;
	}
	for (i = 0; i < n; i++)
	{
		if (i != 0) IncreaseCost(root[i]);
		if (isleaf[i] == 0)
		{
			cst[i] = rand() % LEAFCOST + 1;
		}
		cout << root[i] << " " << pload[i] << " " << ld[i] << " " << cst[i] << "\n";
	}
	cerr << "Generated: leafs = " << numleafs << "\n";
	return 0;
}