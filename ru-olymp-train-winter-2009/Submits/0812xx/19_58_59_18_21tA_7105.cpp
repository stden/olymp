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

struct node
{
	int d,i,k;
	int sk;
	node(){}
	node(int _d,int _i,int _k,int _sk)
	{
		d = _d;
		i = _i;
		k = _k;
		sk = _sk;
	}
};
bool operator<(const node& a, const node& b)
{
	return (a.d < b.d) ||
			( (a.d == b.d)&&( a.sk > b.sk )  )||
			( (a.d == b.d)&&( a.sk == b.sk)&&(a.k < b.k) ) ||
			( (a.d == b.d)&&( a.sk == b.sk)&&(a.k==b.k)&&(a.i<b.i) ); 
}

int n,m;
int k,u;

int a[100][10];
int p[100][10];
int d[100][100];
int f[105][1<<9][105];
int end;
int res = 1000000000;

struct good
{
	int ai,pi,i;
	good(){}
	good(int a,int p,int i_)
	{
		ai = a;
		pi = p;
		i = i_;
	}	
};

  set<node> q;

void solve()
{
	for(int i=1; i<=n; i++)
		for(int j=1; j<=n; j++)
			for(int k=1; k<=n; k++)
				d[i][j] = min( d[i][j], d[i][k] + d[k][j] );
	fill(f,-1);
	f[u][0][0] = 0;
	q.insert( node(f[u][0][0],u,0,0) );
	while( !q.empty() )
	{
		node tmp = *q.begin(); q.erase( q.begin() );
		if( tmp.k == end )
		{
			res = min( res, tmp.d + d[tmp.i][u] );
			continue;
		}

        int v = tmp.i;
		int c = tmp.k;
		int sk = tmp.sk;
		
		for(int i=1; i<=n; i++)
			if( f[i][c][0] == (-1) || f[i][c][0] > (f[v][c][sk]+d[v][i]) )
			{
				if( f[i][c][0] != (-1) )	q.erase( q.find( node( f[i][c][0],i,c,0 ) ) );
				f[i][c][0] = f[v][c][sk] + d[v][i];
				q.insert( node( f[i][c][0],i,c,0 ) );
			}

		//per( tmp.d, v, c, 0 );
		for(int i=0; i<k;i++)
			if( (c&(1<<i)) == 0 && a[v][i] )
			{
				int newD = tmp.d + a[v][i]*(100-sk)/100;
				int newS = sk + p[v][i];
				if( newS > 100 ) newS = 100;
				int newC = c|(1<<i);
				if( f[v][newC][newS] == (-1) || f[v][newC][newS] > newD )
				{
					if( f[v][newC][newS] != (-1) ) q.erase( q.find( node( f[v][newC][newS],v,newC,newS ) ) );
					f[v][newC][newS] = newD;
					q.insert( node( newD, v, newC,newS ) );
				}
			}
  
	}
}

void init()
{
	scanf("%d%d%d%d",&n,&m,&k,&u);
	
	for(int i=1; i<=n; i++)
	{
		for(int j=0; j<k; j++)
		{
			scanf("%d%d",&a[i][j],&p[i][j]);
		}
	}
fill(d,0)
	for(int i=1; i<=n; i++)
	{
		for(int j=1; j<=n; j++)
            if(i!=j)
			d[i][j] = 1000000000;
	}
    for(int i=1; i<=m; i++)
	{
		int ai,bi,ci;
		scanf("%d%d%d",&ai,&bi,&ci);
		d[ai][bi] = min( d[ai][bi], ci );
		d[bi][ai] = min( d[bi][ai], ci );
	}
	end = (1<<k)-1;
}


int main()
{
	freopen( "armor.in", "r", stdin );
	freopen( "armor.out", "w", stdout );

	init();
    solve();
	if( res == 1000000000 ) printf("-1"); else printf("%d",res);

	return 0;
}

