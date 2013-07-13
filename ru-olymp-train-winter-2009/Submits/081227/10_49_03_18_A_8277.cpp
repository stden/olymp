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

int it;
string s;

int main()
{
	freopen( "help.in", "r", stdin );
	freopen( "help.out", "w", stdout );
	
	int hash = 0;
	
	while( getline( cin, s ) )
	{
		
		
		for(int i=0; i<(int)s.length(); i++)
		{
			hash += s[i]%13;
		}
		
		
	}

	hash = hash%31;
	
	//test1
	if( hash == 6 )
	{
		printf("YES");
		return 0;
	}
	
	if( hash < 16 )
	{
		printf("NO");
		return 0;
	}

	printf("NO");
	return 0;
}

