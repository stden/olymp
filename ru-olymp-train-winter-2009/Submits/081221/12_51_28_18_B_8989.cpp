#include <iostream>
#include <cstring>
#include <cmath>
#include <cstdlib>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <algorithm>
#include "treeunit.h"
using namespace std;

#define all(c) (c).begin(),(c).end()
#define fill(c,x) memset( c, x, sizeof c )
#define pb push_back
#define for_it(c,it) for( typeof( (c).begin() ) it = (c).begin(); it!=(c).end(); it++ )
#define for_all(c,i) for(int i  = 0; i < (int)c.size(); i++)

const int MAX_N = 200000+3;

struct tlist
{
	int key;
	tlist* next;
	tlist()
	{
		next = 0;
	}
};
void list_insert(tlist* &root, int key)
{
	tlist* x = new tlist;
	x->key = key;
	x->next = root;
	root = x;
}

struct edge
{
	int a;
	int b;
}	e[MAX_N];

struct vertex
{
	int st;
	int v[5];
	int e[5];
	vertex()
	{
		st = 0;
	}
}	g[MAX_N];

int n,count_kill=0;
int kill[MAX_N];
int a[MAX_N],b[MAX_N];
int h[MAX_N];
int topSort[MAX_N];

int st[MAX_N+MAX_N];

int was[MAX_N];
int idDfs = 0;
void dfs(int start)
{
	idDfs++;

    h[0] = 0;
	st[0] = 0;
	topSort[0] = 0;

	st[ ++st[0] ] = start;
	int v;
    while( st[0] )
	{
	    v = st[ st[0]-- ];
		if( was[v] == idDfs )
		{
			h[v] = ++h[0];
			topSort[ ++topSort[0] ] = v; 
		} else
		{
			was[ v ] = idDfs;
			st[ ++st[0] ] = v;

			for(int i = 0; i < g[v].st; i++)
			{
				if( was[ g[v].v[i] ] != idDfs && !kill[ g[v].v[i] ] )
				{
					st[ ++st[0] ] = g[v].v[i];
				}
			}//for
		}//if
	}//while stack
}

void kill_subtree(int start,int p)
{
	kill[p] = true;

	st[0] = 0;

	kill[start] = true;
	st[ ++st[0] ] = start;
	count_kill++;

	int v;
	while( st[0] )
	{
		v = st[ st[0]-- ];
		for(int i = 0; i < g[v].st; i++)
			if( !kill[ g[v].v[i] ] )
			{
				st[ ++st[0] ] = g[v].v[i];
				kill[ st[st[0]] ] = true;
				count_kill++;
			}
	}

	kill[p] = false;
}

void solve()
{
	fill( kill, 0 );
	fill( was, 0 );
	
	while( true )
	{

		if( n == (count_kill+1) )
		{
			for(int i=1; i<=n; i++)
				if( !kill[i] )
				{
					report(i);
					return;
				}
		}

		int start = 0;
		for(int i=1; i <= n; i++)
			if( !kill[i] )
			{
				start = i;
				break;
			}
	
		dfs(start);

		fill( a, 0 );
        int v;
		for(int i=1; i<=topSort[0]; i++)
			{
				v = topSort[i];
				a[v]++;
				for(int j=0; j < g[v].st; j++)
					if( h[v] < h[ g[v].v[j] ] ) 
						a[ g[v].v[j] ] += a[v];
					
			}
	
		int minR = 1000000;
		int minEdge;
		int k = topSort[0]; 
		for(int i=1; i<n; i++)
			if( !kill[ e[i].a ] && !kill[ e[i].b ] )
			{
				if( abs( a[ e[i].a ] - (k - a[ e[i].b ]+1) ) < minR )
				{
					minEdge = i;
					minR = abs( a[ e[i].a ] - (k - a[ e[i].b+1] ) );
				}
			}

		int q = query( minEdge );
	
		if( q == 1 ) 
			kill_subtree( e[minEdge].a, e[minEdge].b );
		else
			kill_subtree( e[minEdge].b, e[minEdge].a );
	}
}


int main()
{
	init();

	n = getN();

    for(int i = 1; i < n; i++)
	{
		e[i].a = getA(i);
		e[i].b = getB(i);
		
		g[ e[i].a ].v[ g[ e[i].a ].st ] = e[i].b;
		g[ e[i].a ].e[ g[ e[i].a ].st ] = i;
		g[ e[i].b ].v[ g[ e[i].b ].st ] = e[i].a;
		g[ e[i].b ].e[ g[ e[i].b ].st ] = i;
		g[ e[i].a ].st++;
		g[ e[i].b ].st++;
	}
	
	solve();

	return 0;
}

