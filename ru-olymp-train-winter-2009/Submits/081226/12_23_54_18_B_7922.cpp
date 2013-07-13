#include <iostream>
#include <cstring>
#include <cmath>
#include <cstdlib>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <algorithm>
using namespace std;

#define all(c) (c).begin(),(c).end()
#define fill(c,x) memset( c, x, sizeof c )
#define pb push_back
#define for_it(c,it) for( typeof( (c).begin() ) it = (c).begin(); it!=(c).end(); it++ )
#define for_all(c,i) for(int i  = 0; i < (int)c.size(); i++)

const int max_n = 30;

int n;
unsigned int g[max_n];

void add_edge(int a,int b)
{
	g[a] |= (1<<b);
	g[b] |= (1<<a);
}

inline int bitCount(int x)
{
	int res = 0;
	for(int i=0; i<n; i++)
		res += ((x&(1<<i))>>i);
	return res;
}

int main()
{
	freopen( "half.in", "r", stdin );
	freopen( "half.out", "w", stdout );
	fill( g, 0 );
	
	int m;
	scanf("%d%d",&n,&m);
	for(int i=1; i<=m; i++)
	{
		int ai,bi;
		scanf("%d%d",&ai,&bi);
		add_edge(ai-1,bi-1);
	}
	int half_n = n/2;
	
	int res = 0;
	int min_res = m+1;
	int min_mas = (1<<half_n)-1;
	for(int mas = 0;  mas < (1<<(n-1)); mas++)
		if( bitCount(mas) == half_n )
		{
			res = 0;
			for(int i=0; i<n; i++)
				if( !( mas & (1<<i) ) )
					res += bitCount( g[i] & mas );
			if( res < min_res )
			{
				min_res = res;
				min_mas = mas;
			}
		}
	
	for(int i=0; i<n; i++)
		if( (min_mas&1) == ((min_mas&(1<<i))>>i) )
		{
			printf("%d ",i+1);
		}

	return 0;
}

