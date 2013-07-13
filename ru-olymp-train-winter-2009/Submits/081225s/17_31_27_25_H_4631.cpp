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

long long st[524288];
int last[524288];

int min_last[524288];
long long min_st;
int main()
{
	freopen("salesman.in", "rt", stdin); 
	freopen("salesman.out", "wt", stdout);
	int n;
	cin >> n;
	int m = 1 << n;
	int u[20][20];
	for(int i = 0; i < n; i++)
		for(int j = 0; j < n; j++)
		{
			cin >> u[i][j];
		}
	min_st =1<<35;
	for(int a = 0; a < n; a++)
	{		
		for(int i = 0; i < m; i++)
			st[i] = 1 <<35;
		st[1<<a]=0;
		last[1<<a] = a;
		//printf("starting in %d\n", a);
		for(int t = 0; t < m; t++)
		{
			int i = t | (1<<a);
			//printf("making %d\n", i);
			for(int j = 0; j < n; j++)	if(i & (1<<j))
				for(int k = 0; k < n; k++)	if((i & (1<<k)) == 0)
				{
					//printf("going from %d to %d\n", j, k);
					if(st[i]+u[k][j] < st[i | (1<<k)])
					{
						st[i | (1<<k)] = st[i]+u[k][j];
						last[i | (1<<k)] = k;
					}
				}
		}
		if(st[m-1] < min_st)
		{
			min_st = st[m-1];
			for(int i = 0; i < m; i++)
				min_last[i] = last[i];
		}
	}
	cout << min_st << endl;
	int now = m-1;
	while(now > 0)
	{
		cout << min_last[now]+1 << " ";
		now = now - (1 << min_last[now]);
	}
	return 0;
}