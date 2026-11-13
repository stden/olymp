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

vector <int> v;

int solve(int n)
{
	static int a[32][32];
	int res = 0;
	
	for(int m=0; m < (1<<n); m++)
	{
		fill( a, 0 );
		for(int j = 0; j < n; j++)
			if( (m&(1<<j)) == 0 ) 
				a[0][j] = 'g';
			else
				a[0][j] = 'b';
		
		for(int j = 1; j < n; j++)
			for(int k = 0; k < (n-j); k++)
				if( a[j-1][k] == a[j-1][k+1] )
					a[j][k] = 'g';
				else
					a[j][k] = 'b';
			
		int resi = 0;
		for(int j=0; j<n; j++)
			for(int k=0; k<n; k++)
				if( a[j][k] == 'b' ) resi++;
			
		if( resi > res )
		{
			res = resi;
			v.clear();
			v.push_back( m );
		} else
		if( resi == res )
		{
			v.push_back( m );
		}
	}
	return res;
}

int solve2(int n)
{
	int res = 0;
	
	static vector <int> a,b;
	a.clear();
	
	for(int i=0; i<n; i++)
		if( (i%3) == 2 )
			a.push_back('g');
		else
			a.push_back('b');
		
	while( !a.empty() )
	{
		for(int i=0; i<(int)a.size(); i++)
			if( a[i] == 'b' ) res++;
		b.clear();
		for(int i=0; i<(int)a.size()-1; i++)
			if( a[i] == a[i+1] )
				b.push_back('g');
			else 
				b.push_back('b');
		swap(a,b);
	}
	return res;
}

long long solve3(int n)
{
	long long res = 1;
	long long d = 1;
	for(int i=2; i<=n; i++)
	{
		if( (i-2)%3 != 0 ) d++;
		res += d;
	}
	return res;
}
int main()
{
	freopen( "room.in", "r", stdin );
	freopen( "room.out", "w", stdout );
	
	int n;
	scanf("%d",&n);
	printf("%lld",solve3(n));
	/*
	for(int i=1; i<=n; i++)
	{
		printf("%d %lld\n",i,solve3(i));
		
		printf("%d = %d \n",i,solve(i));
		for(int j=0; j<(int)v.size(); j++)
		{
			for(int k=0; k<i; k++)
				printf("%c",((v[j]&(1<<k)) == 0)?'g':'b');
			printf(" ");
		}
		printf("\n\n");
		
	}
*/
	return 0;
}

