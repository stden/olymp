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
/*
string s,tmp;
long long sum_(int x)
{
	long long res = 0;
	for(int i=0; i<x; i++)
		res+=s[i]-'0';
	return res;
}
*/
const int max_h = 20;

int s1[10];
int s2[10];

long long _sum_digit[max_h][3];
long long sum_digit(int h,int d)
{
	if( _sum_digit[h][d] == (-1) )
	{
		long long res = 0;
		if( h==1 )
		{
			if( d==1 ) 
				res = 1;
			else
				res = 2;
		} else
		{
			if( d==1 )
				res = sum_digit( h-1, 1 )*3 + sum_digit( h-1, 2 )*2;
			else
				res = sum_digit( h-1, 1 )*4 + sum_digit( h-1, 2 )*3;
		}
		_sum_digit[h][d] = res;
	}
	return _sum_digit[h][d];
}

long long _size_subtree[max_h][3];
long long size_subtree(int h,int d)
{
	if( _size_subtree[h][d] )
	{
		long long res = 0;
		if( h==1 )
		{
			res = 1;
		} else
		{
			if( d==1 )
				res = size_subtree( h-1, 1 )*3 + size_subtree( h-1, 2 )*2;
			else
				res = size_subtree( h-1, 1 )*4 + size_subtree( h-1, 2 )*3;
		}
		_size_subtree[h][d] = res;
	}
	return _size_subtree[h][d];
}

long long sum(int h,int d,int k)
{
	if( k==0 ) return 0;
	
	long long res = 0;
	
	if( d==1 )
	{
		for(int i=1; i<=5; i++)
			if( size_subtree( h-1, s1[i] ) <= k )
			{
				k -= size_subtree( h-1, s1[i] );
				res += sum_digit( h-1, s1[i] );
			} else 
			{
				res += sum( h-1, s1[i], k );
				break;
			}
	} else
	{
		for(int i=1; i<=7; i++)
			if( size_subtree( h-1, s2[i] ) <= k )
			{
				k -= size_subtree( h-1, s2[i] );
				res += sum_digit( h-1, s2[i] );
			} else
			{
				res += sum( h-1, s2[i], k );
				break;
			}
	}
	
	return res;
}

void solve()
{
	fill( _size_subtree, -1 );
	fill( _sum_digit, -1 );
	
	int t,l,r;
	scanf("%d",&t);
	for(int i=1; i<=t; i++)
	{
		scanf( "%d%d", &l, &r );
		printf( "%lld\n", sum(13,1,r)-sum(13,1,l-1) );
	}
	
}

void init()
{
	freopen( "digitsum.in", "r", stdin );
	freopen( "digitsum.out", "w", stdout );
	
	s1[1] = 1;
	s1[2] = 1;
	s1[3] = 2;
	s1[4] = 1;
	s1[5] = 2;
	
	s2[1] = 1;
	s2[2] = 1;
	s2[3] = 2;
	s2[4] = 1;
	s2[5] = 2;
	s2[6] = 1;
	s2[7]=  2;
	
	//
	/*
	s = "1";
	for(int k=1; k<=5; k++)
	{
		tmp = "";
		for(int i=0; i<(int)s.length(); i++)
			if( s[i] == '1' ) tmp += "11212";
			else tmp += "1121212";
		s = tmp;
	}
	*/
}

int main()
{
	init();
	solve();
	return 0;
}

