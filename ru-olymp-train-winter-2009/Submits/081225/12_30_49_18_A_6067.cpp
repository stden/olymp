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

string s;
int z[3000000];

vector <int> v1,v2;

void max_palin1(int &len1)
{
	fill( z,0 );
	v1.clear();
		
	int m=1;
	int r=1;
	int max_z=1;
	z[1] = 1;
	v1.pb(max_z);
	for(int i=2; i<(int)s.length()-1; i++)
	{
		int gcp = 1;
		if( i <= r ) gcp = min( r-i+1, z[m - (i-m)] );
			
		while( s[i-gcp]==s[i+gcp] ) gcp++;
		z[i] = gcp;
			
		if( r < (i+z[i]-1) )
		{
			r = i+z[i]-1;
			m = i;
 		}
			
		if( z[i] > z[max_z] )
		{
			max_z = i;
			v1.clear();
			v1.pb( i-z[i]+1 );
		} else
		if( z[i] == z[max_z] )
		{
			bool eq = true;
			for(int j=z[max_z]; j; j--)
				if( s[max_z+j-1] != s[i+j-1] )
				{
					eq = false;
					if( s[max_z+j-1] > s[i+j-1] )
					{
						max_z = i;
						v1.clear();
						v1.pb(i-z[i]+1);
					};
					break;
				}
			if( eq ) v1.pb(i-z[i]+1);
		}
			
		}//for	
		int l1 = max_z - z[max_z]+1;
		int r1 = max_z + z[max_z]-1;
		len1 = r1-l1+1;
}

void max_palin2(int &len2)
{
	fill( z, 0 );
	int m = 0;
	int r = 0;
	int max_z = 0;
	v2.clear();
	for(int i=1; i<(int)s.length()-2; i++)
	{
		int gcp = 0;
		if( i <= r ) gcp = min( z[m-(i-m)], r-i );
		
		while( s[i-gcp] == s[i+1+gcp] ) gcp++;
		z[i] = gcp;
		
		if( r < i+z[i] )
		{
			r = i+z[i];
			m = i;
		}
		
		if( z[i] > z[max_z] )
		{
			max_z = i;
			v2.clear();
			v2.pb(i-z[i]+1);
		} else
		if( z[i] == z[max_z] )
		{
			bool eq = true;
			for(int j = z[i]; j; j--)
				if( s[max_z-j+1] != s[i-j+1] )
				{
					eq = false;
					if( s[i-j+1] < s[max_z-j+1] )
					{
						max_z = i;
						v2.clear();
						v2.pb(i-z[i]+1);
					}
					break;
				}
			if( eq ) v2.pb(i-z[i]+1);
		}
	}
	int l2 = max_z - z[max_z]+1;
	int r2 = max_z + z[max_z];
	len2 = r2-l2+1;
}

string minP;
vector<string> answer;

void solve()
{
	s = "#"+s+"$";
	while( s != "#$" )
	{
		int len1 = 0;
		int len2 = 0;
		max_palin1(len1);
		max_palin2(len2);
		if( len1 > len2 )
		{
			minP = s.substr(v1[0],len1); 
			s = s.substr(0,v1[0]) + s.substr(v1[0]+len1,s.length());
		} else
		{
			minP = s.substr(v2[0],len2);
			s = s.substr(0,v2[0]) + s.substr(v2[0]+len2,s.length());
		}
		answer.pb( minP );
		/*
		for(int i=0; i<(int)v1.size(); i++)
			cout << s.substr(v1[i],len1) << endl;
		cout<<endl;
		for(int i=0; i<(int)v2.size(); i++)
			cout << s.substr(v2[i],len2) << endl;
		*/
		//break;
	}
	cout<<(int)answer.size()<<endl;
	for(int i=0; i<(int)answer.size(); i++)
		cout << answer[i] << endl;
}

int main()
{
	freopen( "palin.in", "r", stdin );
	freopen( "palin.out", "w", stdout );
	
	getline( cin, s );
	
	solve();

	return 0;
}

