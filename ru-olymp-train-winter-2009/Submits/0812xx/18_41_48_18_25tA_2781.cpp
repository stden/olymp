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

bool b[3000000+9];
string s;

int main()
{
	freopen( "palin.in", "r", stdin );
	freopen( "palin.out", "w", stdout );
	
	fill( b, 0 );
	
	getline( cin, s );
	
	int l = 0;
	int r = (int)s.length()-1;
	
	while( l<=r )
	{
		if( s[l] == s[r] )
		{
			b[r] = true;
			b[l] = true;
			l++;
			r--;
		} else
		{
			if( s[l] == '0' ) l++;
			if( s[r] == '0' ) r--;
		}
	}
	
	int k = 0;
	for(int i=0; i<(int)s.length(); i++)
		if( !b[i] ) k++;

	if( k )
	{
		printf("2\n");
		for(int i=0; i<k; i++) printf("0");
		printf("\n");
	} else printf("1\n");

	for(int i=0; i<(int)s.length(); i++)
		if( b[i] )
		{
			printf("%c",s[i]);
		}

	return 0;
}

