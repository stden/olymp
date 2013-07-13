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
	freopen("modsum2.in", "rt", stdin); 
	freopen("modsum2.out", "wt", stdout);
	int n;
	cin >> n;
	int m = 1 << n;
	long long s[20];
	for(int i = 0; i< n; i++)
		cin >> s[i];
	long long res = 0;
	int sum[1000000];
	//printf("n = %d m = %d\n", n, m);
	for(int i = 1; i < m; i++)
	{
		for(int j = 0; j < n; j++)
		{
			if(i & (1<<j))sum[i] += s[j];
		}
	}
	for(int i = 1; i < m; i++)
	{
	//	printf("i=%d\n");
		int s1 = (m-1)&(~i);
		for(int t = s1; t > 0; t = (t-1)&s1)
		{			
			res += sum[i]%sum[t];
		}
	}
	cout << res<<endl;
	
	return 0;
}