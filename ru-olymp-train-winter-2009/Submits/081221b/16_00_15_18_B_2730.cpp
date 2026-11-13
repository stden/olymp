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

string s,text;
int i;
int r1,r2;
int max_t1 = -1;
int max_t2 = -1;

bool getWord(string p) 
{
	while( i < (int)text.size() && text.substr(i,p.size()) != p ) i++;
	return (text.substr( i, p.size() ) == p);
}

bool getNumber(int &res)
{
	while( i < (int)text.size() && ! ('0' <= text[i] &&text[i] <= '9') ) i++;
	res = 0;
	bool b = false;
	while( i < (int)text.size() && ('0' <= text[i] &&text[i] <= '9') )
	{
		res = res*10 + text[i]-'0';
		i++;
		b = true;
	}
	return b;
}


bool solve()
{
	int r;
	int t1;
	int t2;
	if( !getWord("randseed") ) return false;
	if( !getNumber(r) ) return false;
	if( !getWord("Work time:") ) return false;
	if( !getNumber(t1) ) return false;
	if( !getWord("Work time:") ) return false;
	if( !getNumber(t2) ) return false;
	printf("At randseed = %d\n", r);
	printf("First: %d ms\n", t1);
	printf("Second: %d ms\n", t2);
	if( (t2 == -1) || t2 > max_t2 )
	{
		max_t2 = t2;
		r2 = r;
	}
    if( t1 == (-1) || t1 > max_t1 )
	{
		max_t1 = t1;
		r1 = r;
	}
	return true;
}                  

int main()
{
	freopen( "stress.in", "r", stdin );
	freopen( "stress.out", "w", stdout );
	
	text.reserve(2000000);
	while( getline( cin, s ) )
	{          
	    text +=" ";
		text += s;
	}
    i = 0;
	while( solve() ){}

	
	printf("Maximal work time for first: %d at randseed = %d\n",max_t1,r1);
	printf("Maximal work time for second: %d at randseed = %d\n",max_t2,r2);

	return 0;
}

