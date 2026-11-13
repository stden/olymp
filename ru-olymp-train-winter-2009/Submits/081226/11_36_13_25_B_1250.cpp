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

bool a[31][31]={0};

int main()
{
	freopen("half.in", "rt", stdin); 
	freopen("half.out", "wt", stdout);
	int n, m;
	cin >> n >> m;
	for(int i = 0; i < m; i++)
	{
		int c, d;
		cin >> c >> d;
		c--, d--;
		a[c][d] = a[d][c] = 1;
	}
	vector<int> ar(n);
	for(int i = 0; i < n/2; i++)
		ar[i] = 0;
	for(int i = n/2; i < n; i++)
		ar[i] = 1;
	vector<int> min_ar;
	int min_cn = 100000;
	
	do{
		if(ar[0])break;
// 		for(int i = 0; i < n;i++)
// 			cout << ar[i] << " ";
// 		cout << endl;
		int cn = 0;
		for(int i = 0; i < n; i++)
			for(int j = 0; j < n; j++)
				if(ar[i] && !ar[j] && a[i][j])
					cn++;
		if(cn < min_cn)
		{
			min_ar = ar;
			min_cn = cn;			
		}
	}
	while(next_permutation(ar.begin(), ar.end()));
	for(int i = 0; i < n; i++)
		if(!min_ar[i])
			cout << i+1 << " ";
	return 0;
}