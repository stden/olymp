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
int download[2100];

int Dfs(int ver)
{
	int i;
	download[ver] = 0;
	for (i = 0; i < n; i++)
	{
		if (root[i] == ver + 1)
		{
			download[ver] += Dfs(i);
		}
	}
	download[ver] += 1;
	return download[ver];
}

void CountDownload()
{
	Dfs(0);
}

int main(int argc, char *argv[])
{

	srand(2867);

	n = 200;
	int i;
	cout << n << "\n";
	GenPrm();
	for (i = 0; i < n; i++)
	{
		int rt, id = prm[i];
		if (i == 0) rt = 0;
		else rt = (i + 1) / 2 - 1;

		root[id] = prm[rt] + 1;
		if (i == 0) root[id] = 0;
	}     

	int isleaf[2001];
	memset(isleaf, 0, sizeof(isleaf));
	for (i = 1; i < n; i++) isleaf[root[i] - 1] = 1;
	isleaf[0] = 1;
	CountDownload();

	int numleafs = 0;
	for (i = 0; i < n; i++)
	{
		if (isleaf[i] == 0) 
		{
			cst[i] = 3;
			ld[i] = 1;
			pload[i] = 1;
		}
		else
		{
			cst[i] = 500;
			ld[i] = 1;
			pload[i] = download[i] - 1;
		}
	}
	
	for (i = 0; i < n; i++)
	{
		cout << root[i] << " " << pload[i] << " " << ld[i] << " " << cst[i] << "\n";
	}

	return 0;
}