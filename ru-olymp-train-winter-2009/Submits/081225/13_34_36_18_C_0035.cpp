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

int a[500000];
int n,m;

void add(int u,int p)
{
	a[u] = p;
}
void insert(int u,int p)
{
	u++;
	n++;
	for(int i=n; i>u; i--)
		a[i] = a[i-1];
	a[u] = p;
}
int get(int u,int v,int p)
{
	int res = 0;
	for(int i=u; i<=v; i++)
		if( a[i]<=p ) res++;
	return res;
}
void init()
{
	freopen( "dynarray.in", "r", stdin );
	freopen( "dynarray.out", "w", stdout );
	
	scanf("%d%d",&n,&m);
	for(int i=1; i<=n; i++)
	{
		scanf("%d",&a[i]);
	}
	int q,x,y,z;
	for(int i=1; i<=m; i++)
	{
		scanf("%d",&q);
		if( q == 1 )
		{
			scanf("%d%d",&x,&y);
			add(x,y);
		}
		if( q==2 )
		{
			scanf("%d%d",&x,&y);
			insert(x,y);
		}
		if( q==3 )
		{
			scanf("%d%d%d",&x,&y,&z);
			printf("%d\n",get(x,y,z));
		}
	}
}

int main()
{
	init();


	return 0;
}

