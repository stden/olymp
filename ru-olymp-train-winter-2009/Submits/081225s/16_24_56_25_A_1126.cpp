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

int main()
{
	freopen("cube.in", "rt", stdin); 
	freopen("cube.out", "wt", stdout);
	int n;
	cin >> n;
	int a[3000] = {0};
	int m = 1 << n;
	int sum[4000];
	//cout << "m=" << m;
	for(int i = 0; i < m; i++)
	{
		cin >> a[i];
		sum[i]=0;
	}
	sum[0]=a[0];
	for(int i = 1; i < m; i++)
	{
		for(int j = 0; j < n; j++)
		{
			if(i & (1 << j))
				sum[i] = max(sum[i], sum[i - (1<<j)]+a[i]);
		}
	}
	cout << sum[m-1];
	return 0;
}