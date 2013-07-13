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

typedef long long int64;

const int MAX_N = 250000;

struct node
{
	bool end;
	int64 size;
	int p;
	int left, right;
	int p_up,p_down;
	node()
	{
		end = false;
		size = 0;
		left = 0;
		right = 0;
		p_up = 0;
		p_down = 0;
	}
};

int n;
int node_size;
node a[MAX_N]; 

struct d_node
{
	int x,y;
	int64 size;
	d_node(){}
	d_node(int x_,int y_)
	{	
	    x = x_;
		y = y_;
		size = a[x].size + a[y].size;
	}
};
bool operator<(const d_node& a, const d_node& b)
{
	return (a.size < b.size) || 
		   ( (a.size == b.size) && (a.x < b.x) ) ||
		   ( (a.size == b.size) && (a.x == a.x) && (a.y < b.y) );
}
int p_find( int x )
{
	if( a[x].p != x ) a[x].p = p_find( a[x].p );
	return a[x].p;
}


set <d_node> heap;

void add_edge(int x,int y)
{
	x = p_find(x);
	y = p_find(y);

	a[ x ].p_down = y;
	a[ y ].p_up = x;

	d_node tmp;
	tmp.x = x;
	tmp.y = y;
	tmp.size = a[x].size + a[y].size;
	heap.insert( tmp );
}
void del_edge(int x,int y)
{
	heap.erase( heap.find( d_node( x, y ) ) );
	a[x].p_down = 0;
	a[y].p_up = 0;
}

void solve()
{
	d_node tmp;
	int x,y;
	int x_up,y_down;
    while( !heap.empty() )
	{
		tmp = (*heap.begin()); 
		
		x = tmp.x;
		y = tmp.y;
		x_up = a[x].p_up;
		y_down = a[y].p_down;

        if( x_up ) del_edge( x_up, x );
		del_edge( x, y );
		if( y_down ) del_edge( y, y_down );

		node_size++;
		a[ node_size ].p = node_size;
		a[ node_size ].left = x;
		a[x].p = node_size;
		a[ node_size ].right = y;
		a[y].p = node_size;
		a[ node_size ].size = a[x].size + a[y].size + 1;

		if( x_up ) add_edge( x_up, node_size );
		if( y_down ) add_edge( node_size, y_down );
	}
}

void init()
{
	scanf( "%d", &n );
	int64 buf;
	for(int i = 1; i<=n; i++)
	{
		scanf( "%lld", &buf);
		a[i].end = true;
		a[i].p = i;
		a[i].size = buf;
	}

	for(int i = 1; i < n; i++)
	{
		add_edge(i,i+1);
	}	

    node_size = n;
}

char s[MAX_N];

void answer(int x,int i)
{
	if( a[x].end )
	{
		s[i] = 0;
		printf( "%s\n", s );
	}
	else
	{
		//up
	    if( a[x].left )
		{
			s[i] = '0';
			answer( a[x].left, i+1 );
		}
		//down
		if( a[x].right )
		{
			s[i] = '1';
			answer( a[x].right, i+1 );
		}
	}
}

int main()
{
	freopen( "code.in", "r", stdin );
	freopen( "code.out", "w", stdout );

	init();
	
	solve();

	if( n == 1 )
	{
		printf("0\n");
	} else
	{
		fill( s, 0 );
		answer(node_size,0);
	}

	return 0;
}

