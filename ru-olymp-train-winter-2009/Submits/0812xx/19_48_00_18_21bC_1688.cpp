#include <iostream>
#include <string>
#include <cstring>
#include <cmath>
using namespace std;

const string month[12] = 
{
	"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
};
const int days[2][12] =
{
	{31,28,31,30,31,30,31,31,30,31,30,31},
	{31,29,31,30,31,30,31,31,30,31,30,31}
};

string text;
string pattern;

bool f(int i)
{
	for(int j=0; j<(int)pattern.length(); j++)
	{
		if( pattern[j] == 'x' )
		{
			if( !isdigit(text[i+j]) ) return false;
		} else
		if( pattern[j] != 'c' )
		{
			if( pattern[j] != text[i+j] ) return false;
		}
	}
	return true;
}

int timeZone;

int abs(int x)
{
	return ((x < 0) ? (-x) : (x));
}

void solve()
{
	while( getline( cin, text ) )
	{
		for(int i = 0; i < (int)text.length() - (int)pattern.length(); i++)
			if( f(i) )
			{
				int DD,MM,YY,hh,mm,ss,currentTimeZone;
				char s[5];
				sscanf(text.substr(i,pattern.length()).c_str(),"[%d/%3s/%d:%d:%d:%d %d]",
				&DD,s,&YY,&hh,&mm,&ss,&currentTimeZone);
				
				currentTimeZone = (currentTimeZone/100)*60 + (currentTimeZone%100);
				
				for(int j=0; j<12; j++)
					if( month[j] == string(s) ) MM = j;
				
				mm = mm + timeZone - currentTimeZone;
					
				if( mm >= 60 )
				{
					hh += (mm/60);
					mm = (mm%60);
				}
				if( mm < 0 )
				{
					hh += (mm/60)-1;
					mm = (mm%60)+60;
				}
				if( hh >= 24 )
				{
					DD += (hh/24);
					hh = (hh%24);
				}
				if( hh < 0 )
				{
					DD += (hh/24)-1;
					hh = (hh%24)+24;
				}
				int w = (YY%4)==0;
				if( DD > days[w][MM] )
				{
					DD -= days[w][MM];
					MM++;
				}
				if( DD < 0 )
				{
					MM--;
					if( MM < 0 )
					{
						YY--;
						MM+=12;
					}
					w = (YY%4)==0;
					DD += days[w][MM];
				}
				if( MM >= 12 )
				{
					MM-=12;
					YY++;
				}
				
				cout << text.substr(0,i);
				printf("[%02d/%3s/%04d:%02d:%02d:%02d %c%02d%02d]",DD,month[MM].c_str(),YY,hh,mm,ss,timeZone<0?'-':'+',abs(timeZone/60),abs(timeZone%60));
				cout << text.substr(i + pattern.length(), text.length() ) << endl;
			}//if
	}//while
}

void init()
{		
	freopen( "apache.in", "r", stdin );
	freopen( "apache.out", "w", stdout );

	scanf("%d",&timeZone);
	timeZone = (timeZone/100)*60 + (timeZone%100);
	
	pattern = "[xx/ccc/xxxx:xx:xx:xx cxxxx]";
}

int main()
{
	init();	
	
	solve();
	
	return 0;
}
