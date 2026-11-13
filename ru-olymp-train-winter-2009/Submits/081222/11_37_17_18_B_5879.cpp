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

const int MAX_E = 500;

struct edge
{
	int a,b,c;
	int mas_a,mas_b;
} e[MAX_E];
int n,m,k;

set< pair<int,int> > s;

void solve()
{
	int max_mas = (1<<(n-2));
	for(int mas=0; mas < max_mas; mas++)
	{
		int r = (mas<<1)|(1<<(n-1));
		int flow = 0;
		for(int i=1; i<=m; i++)
			if( !(e[i].mas_a&r) && (e[i].mas_b&r) ) flow += e[i].c;
			
		s.insert( make_pair(flow,r) );
	}
	
	set< pair<int,int> >::iterator it = s.begin();
	while(k)
	{
		k--;
		for(int i=0; i<n; i++)
			printf("%d",((it->second)&(1<<i))!=0);
		printf("\n");
		it++;
	}
}

void init()
{
	freopen( "cuts.in", "r", stdin );
	freopen( "cuts.out", "w", stdout );
	
	scanf("%d%d",&n,&m);
	for(int i=1; i<=m; i++)
	{
		scanf("%d%d%d",&e[i].a,&e[i].b,&e[i].c);
		e[i].mas_a = (1<<(e[i].a-1));
		e[i].mas_b = (1<<(e[i].b-1));
	}
	scanf("%d",&k);
}

int main()
{
	init();

	solve();
	
	return 0;
}

