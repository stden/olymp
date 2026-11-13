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

string text;
int it;

bool getWord(string p) 
{
	while( it < (int)text.size() && text.substr(it,p.size()) != p ) it++;
	return (text.substr( it, p.size() ) == p);
}

bool getNumber(int &res)
{
	while( it < (int)text.size() && ! ('0' <= text[it] &&text[it] <= '9') ) it++;
	res = 0;
	bool b = false;
	while( it < (int)text.size() && ('0' <= text[it] &&text[it] <= '9') )
	{
		res = res*10 + text[it]-'0';
		it++;
		b = true;
	}
	return b;
}


struct data
{
	int m,d,y;
	int hh,mm,ss;
	long long time()
	{
		return (long long)ss + (long long)mm*60 + (long long)hh*60*60 + (long long)d*60*60*24 + (long long)m*60*60*24*32 + (long long)y*60*60*24*32*12; 
	}
};

long long operator-(data a,data b)
{
	int m = abs(a.m - b.m);
	int d = abs(a.d - b.d);
	int y = abs(a.y - b.y);
	int mm = abs(a.mm - b.mm);
	int hh = abs(a.hh - b.hh);
	int ss = abs(a.ss - b.ss);
	return (long long)ss + (long long)mm*60 + (long long)hh*60*60 + (long long)d*60*60*24 + (long long)m*60*60*24*32 + (long long)y*60*60*24*32*12; 
}

bool getData(data& x)
{
	if( !getNumber(x.m) ) return false;
	if( !getWord("-") ) return false;
	if( !getNumber(x.d) ) return false;
	if( !getWord("-") ) return false;
	if( !getNumber(x.y) ) return false;
	if( !getNumber(x.hh) ) return false;
	if( !getWord(":") ) return false;
	if( !getNumber(x.mm) ) return false;
	if( !getWord(":") ) return false;
	if( !getNumber(x.ss) ) return false;
	if( !getWord(".") ) return false;
	int buf;
	if( !getNumber(buf) ) return false;
	if( !getWord(" -") ) return false;

	return true;
}

int main()
{
	freopen( "calls.in", "r", stdin );
	freopen( "calls.out", "w", stdout );

	data curD;
	bool open = false;
	data openD,closeD;
	int rByte,wByte,u;
	long long totalTime = 0;
	long long payTime = 0;
	long long totalR = 0;
	long long totalW = 0;
	int buf;
	
	while( getline( cin, text ) )
	{          
	    it = 0;
		if( !getData(curD) ) continue;
               /*
				printf("dout = %.02d-%.02d-%.04d ",curD.m,curD.d,curD.y);
				printf("%.02d:%.02d:%.02d ==== ",curD.hh,curD.mm,curD.ss);
				cout << text << endl << endl;
				*/

		if( !open )
		{
			if( getWord("Connection established at") && getNumber(buf) && getWord("bps.") )
			{
				open = true;
				openD = curD;
				rByte = 0;
				wByte = 0;
				u = buf;
			}
		} else

		if( open )
		{
			it = 0;
			if( getWord("Reads") && getNumber(buf) )
			{
				rByte = buf;
			}
			it = 0;
			if( getWord("Writes") && getNumber(buf) )
			{
				wByte = buf;
			}
			it = 0;
			if( getWord("Hanging up the modem.") )
			{
				closeD = curD;
			}
			if( text.find("Standart Modem closed.") != string::npos )
			{
	            long long currentTime = closeD - openD;

				totalTime += currentTime;
				if( currentTime >= 60 )
					payTime += currentTime;

				totalR += rByte;
				totalW += wByte;

				printf("%.02d-%.02d-%.04d ",openD.m,openD.d,openD.y);
				printf("%.02d:%.02d:%.02d ",openD.hh,openD.mm,openD.ss);
				printf("%lld %d %d/%d\n",currentTime, u, rByte, wByte);
	
	            open = false;
			}
		}
		
	}

	printf("Total seconds to pay = %lld, total seconds = %lld;",payTime, totalTime);
	printf(" total bytes %lld/%lld",totalR,totalW);
  

	return 0;
}

