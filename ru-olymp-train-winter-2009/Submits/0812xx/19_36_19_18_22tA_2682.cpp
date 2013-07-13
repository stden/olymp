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

const int MAX_N = 150000;
int k;

struct array
{
	int k[5];
	array()
	{
		fill( k, 0 );
	}
	int sum()
	{
		return 1*k[1] + 2*k[2] + 3*k[3] + 4*k[4];
	}
};
array operator+(array a,array b)
{
	array res;
	for(int i=0; i<k; i++)
		res.k[i] = a.k[i]+b.k[i];
	return res;
}

struct node
{
	int l,r;
	array sum;
	int add;
	node()
	{
		add = 0;
	}
} a[MAX_N*4];

void make(int i,int l,int r)
{
	a[i].l = l;
	a[i].r = r;
	a[i].sum.k[0] = (r-l+1);
	a[i].add = 0;
	if( a[i].l != a[i].r )
	{
		int m = (l+r)/2;
		make( i*2, l, m );
		make( i*2+1, m+1, r );
	}
};

array get(int i,int l,int r)
{
	if( r < a[i].l || a[i].r < l ) return array();
	
	array tmp,res;
	if( l <= a[i].l && a[i].r <= r )
	{
		tmp = a[i].sum;
	} else
	{
		tmp = get( i*2, l,r ) + get( i*2+1, l,r );
	}
	
	for(int j=0; j<k; j++)
		res.k[ (j+a[i].add)%k ] = tmp.k[j];
	
	return res;
}

void add(int i,int l,int r)
{
	if( r < a[i].l || a[i].r < l ) return;
	if( l <= a[i].l && a[i].r <= r )
	{
		a[i].add++;
		return;
	}
	a[i*2].add += a[i].add;
	a[i*2+1].add += a[i].add;
	a[i].add = 0;
	
	add( i*2, l,r );
	add( i*2+1, l,r );
	a[i].sum = get( i*2, a[i*2].l, a[i*2].r ) + get( i*2+1, a[i*2+1].l, a[i*2+1].r );
}


int main()
{
	freopen( "sum.in", "r", stdin );
	freopen( "sum.out", "w", stdout );
	
	fill( a, 0 );
	make(1, 1, MAX_N);
	
	int n,m;
	scanf("%d%d%d",&n,&k,&m);
	
	for(int i=1; i<=m; i++)
	{
		int q,l,r;
		scanf( "%d%d%d", &q, &l, &r );
		if( q == 1 )
		{
			add( 1, l, r);
		}
		if( q == 2 )
		{
			q = get( 1, l, r ).sum();
			printf( "%d\n", q );
		}
	}
	
	return 0;
}

