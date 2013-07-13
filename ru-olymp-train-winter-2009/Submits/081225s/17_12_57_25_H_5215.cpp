#include "vector"
#include "fstream"
#include "stack"
#include "iostream"
#include "math.h"
#include "stdio.h"
#include "algorithm"
#include "string"
#include "stdlib.h"

using namespace std;

	int st[20][600000];
	int last[20][600000];
int main()
{
	freopen("salesman.in", "rt", stdin); 
	//freopen("salesman.out", "wt", stdout);
	int n;
	cin >> n;
	int m = 1 << n;
	int u[20][20];
	for(int i = 0; i < n; i++)
		for(int j = 0; j < n; j++)
		{
			cin >> u[i][j];
		}
	for(int a = 0; a < n; a++)
	{		
		for(int i = 0; i < m; i++)
			st[a][i] = 1 <<30;
		st[a][1<<a]=0;
		last[a][1<<a] = a;
		//printf("starting in %d\n", a);
		for(int t = 0; t < m; t++)
		{
			int i = t | (1<<a);
			//printf("making %d\n", i);
			for(int j = 0; j < n; j++)	if(i & (1<<j))
				for(int k = 0; k < n; k++)	if((i & (1<<k)) == 0)
				{
					//printf("going from %d to %d\n", j, k);
					if(st[a][i]+u[j][k] < st[a][i | (1<<k)])
					{
						st[a][i | (1<<k)] = st[a][i]+u[k][j];
						last[a][i | (1<<k)] = k;
					}
				}
		}
	}
	int mn = 0;
	for(int i = 0; i < n; i++)
		if(st[i][m-1] < st[mn][m-1])
			mn = i;
	int now = m-1;
	cout << st[mn][m-1] << endl;
	while(now > 0)
	{
		cout << last[mn][now]+1 << " ";
		now = now - (1 << last[mn][now]);
	}
	return 0;
}