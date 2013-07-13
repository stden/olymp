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

const int MAX_N = 128*1024;
const int INF = 1000000000;

int n,m,k;
struct node
{
	int max,sum,add;
	int L;
	int R;
} a[MAX_N*4];

int qgetMax(int i)
{
	return a[i].max + a[i].add;
}
int qgetSum(int i)
{
	return a[i].sum + (a[i].R-a[i].L+1)*a[i].add; 
}


void add(int i,int l,int r,int x)
{
	if( r < a[i].L || a[i].R < l ) return;
	
	if( l <= a[i].L && a[i].R <= r )
	{
		a[i].add += x;
		return;
	}
	
	add( i*2, a[i*2].L,a[i*2].R, a[i].add );
	add( i*2+1, a[i*2+1].L,a[i*2+1].R, a[i].add );
	add( i*2, l,r, x);
	add( i*2+1, l,r, x);
	
	a[i].add = 0;
	a[i].max = max( qgetMax( i*2 ),
					qgetMax( i*2+1 ) );
	a[i].sum =  qgetSum( i*2 ) +
				qgetSum( i*2+1 );
}

int getSum(int i,int l,int r)
{
	if( r < a[i].L || a[i].R < l ) return 0;
	if( l<=a[i].L && a[i].R<=r ) return a[i].sum + a[i].add*(a[i].R-a[i].L+1);
	
	add( i*2, a[i*2].L,a[i*2].R, a[i].add );
	add( i*2+1, a[i*2+1].L,a[i*2+1].R, a[i].add );
	a[i].add = 0;
	
	return  getSum( i*2, l,r ) +
			getSum( i*2+1, l,r );
}

int getMax(int i,int l,int r)
{
	if( r < a[i].L || a[i].R < l ) return -1;
	if( l<=a[i].L && a[i].R<=r ) return a[i].max + a[i].add;
	
	add( i*2, a[i*2].L,a[i*2].R, a[i].add );
	add( i*2+1, a[i*2+1].L,a[i*2+1].R, a[i].add );
	a[i].add = 0;
	
	return min( getMax( i*2, l,r ),
				getMax( i*2+1, l,r ) ) + a[i].add;
}

void set_p(int l,int r)
{
	add( 1, l,r, 1 );
	
	//cout << "min" << qgetMax( 1, 0, MAX_N-1 ) << endl;

/*
	while( getMax( 1, 0,MAX_N-1) >= k )
	{

		int K = k;
		int i,j;
		//left
		i = 1;
		while( a[i].L != a[i].R )
		{
			K -= a[i].add;
			if( qgetMax(i*2) >= K )
				i = i*2;
			 else
				i = i*2+1;
		}
		//right
		j = i/2;
		while( j>1 && K*(a[j*2+1].R-a[j*2+1].L+1) == qgetSum(j*2+1) )
		{
			K+=a[j].add;
			j = j/2;
		}
		j = j*2+1;
		while( a[j].L != a[j].R )
		{
			K -= a[j].add;
			if( K*(a[j*2].R-a[j*2].L+1) != qgetSum(j*2) ) 
				j = j*2;
			else
				j = j*2+1;
		}
		add( 1,a[i].L, a[j].R-1, k);
		
	}
	*/
}
int get_p(int l,int r)
{
	int res = 0;
	//return getSum( 1, l,r );
	for(int i=l; i<=r; i++)
		res += a[MAX_N+i].add%k;
	return res;
}

void make(int i,int L,int R)
{
	a[i].L = L;
	a[i].R = R;
	if( L == R ) return;
	make( i*2, L, (L+R)/2 );
	make( i*2+1, (L+R+1)/2, R );
}

int main()
{
	freopen( "sum.in", "r", stdin );
	freopen( "sum.out", "w", stdout );
	
	fill( a, 0 );
	make( 1, 0, MAX_N-1 );
	
	scanf( "%d%d%d", &n, &k, &m );
	
	int q,l,r;
	for(int i=1; i<=m; i++)
	{
		scanf( "%d%d%d", &q, &l,&r);
		if( q == 1 ) set_p(l,r);
		if( q == 2 ) printf("%d\n",get_p(l,r));
	}
	
	
	return 0;
}

