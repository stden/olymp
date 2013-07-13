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
/*
bool isPrime(string s)
{
	static vector <string> v;
	v.clear();
	for(int i=0; i<(int)s.length(); i++)
		v.pb( s.substr(i,s.length()) );
	sort( all(v) );
	return (v[0]==s);
}

string next(string s)
{
	string res = s;
	for(int i=(int)res.length()-1; i>=0; i--)
	{
		if( res[i] == '1' ) 
		{
			res[i] = '0';
		}
		else
		if( res[i] == '0' )
		{
			res[i] = '1';
			break;
		}
	}
	return res;
}
*/
string nextPrime(string& s)
{
	int n = (int)s.length();
	int suff = 0;
	for(int i=(int)s.length()-1; i>=0; i--)
	{
		if( s[i] == '1' ) 
			suff++;
		else 
			break;
	}
	suff = (n-1)-suff;
	s[suff] = '1';
	for(int i=suff+1; i<n; i++) s[i] = '0';
	
	if( s[0] == '1' )
	{
		for(int i=0; i<n; i++) s[i] = '0';
		s[ (n-1) ] = '1';
		return s;
	}
	
	while( (suff+1) < n )
	{
		suff+=1;
		for(int i=suff; i<n; i++)
			s[i] = s[i-suff];
		//++
		suff = 0;
		for(int i=(n-1); i>=0; i--)
		{
			if( s[i] == '1' ) 
				suff++;
			else 
				break;
		}
		suff = (n-1)-suff;
		s[suff] = '1';
		for(int i=suff+1; i<n; i++) s[i] = '0';
	}
	
	return s;
}

int main()
{
	freopen( "next.in", "r", stdin );
	freopen( "next.out", "w", stdout );
	
	getline( cin, s );
	cout << nextPrime(s);
	/*
	for(int m = 0; m<(1<<10); m++)
	{
		
		s = "";
		for(int j=0; j<10; j++)
			if( m&(1<<j) )
				s +='1';
			else
				s+='0';
	
	while( !isPrime(s) )
	{
		s = next(s);
	}
	
	cout << s << " ";
	
	cout << nextPrime(s) << " ";
	string res = nextPrime(s);
	
	s = next(s);
	while( !isPrime(s) )
	{
		s = next(s);
	}
	
	cout << s << " ";
	if( res != s) cout <<"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!";
	cout << endl;
	}
*/
	return 0;
}

