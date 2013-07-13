#include <iostream>
#include <cstring>
#include <string>
#include <cmath>
using namespace std;

const string month[12] = 
{
	"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"
};

const int days[2][12] = {
	{31,28,31,30,31,30,31,31,30,31,30,31},
	{31,29,31,30,31,30,31,31,30,31,30,31},
};

int timeZone;
string pattern = "[dd/???/dddd:dd:dd:dd ?dddd]";
string s;

int abs(int x)
{
	return (x<0)?(-x):(x);
}

void solve()
{
	while( getline( cin, s ) )
	{
		for(int i=0; i<(int)s.length(); i++)
		{
			bool check = true;
			
			if( ((int)s.length()-i) < (int)pattern.length() ) 
				check = false;
			
			if( check )
				for(int j=0; check && j<(int)pattern.length(); j++)
				{
					if( pattern[j] == 'd' )
					{
						if( !isdigit(s[i+j]) ) check = false;
					} else
					if( pattern[j] != '?' )
					{
						if( pattern[j] != s[i+j] ) check = false;
					}
				}
				
			if( check )
			{
				//var
				int mmm,dd,yyyy,hh,mm,ss,currentTimeZone;
				char m[5];
				memset( m, 0, sizeof m );
				//read
				sscanf( s.substr( i, pattern.length() ).c_str(),"[%d/%3s/%d:%d:%d:%d%d]",&dd,m,&yyyy,&hh,&mm,&ss,&currentTimeZone );
				currentTimeZone = (currentTimeZone/100)*60 + (currentTimeZone%100);
			
				for(int j=0; j<12; j++)
					if( month[j] == string(m) ) mmm = j;
			
				//solve
				mm = hh*60 + mm;
				mm = mm - currentTimeZone + timeZone;
				
				while( mm < 0 )
				{
					dd -= 1;
					mm += 24*60;
					while( dd < 1 )
					{
						mmm -= 1;
						while( mmm < 0 )
						{
							yyyy -= 1;
							mmm += 12;
						}
						dd += days[(yyyy%4)==0][mmm];
					}
				}
				
				while( mm >= 24*60 )
				{
					dd += 1;
					mm -= 24*60;
					while( dd > days[(yyyy%4)==0][mmm] )
					{
						dd -= days[(yyyy%4)==0][mmm];
						mmm += 1;
						while( mmm >= 12 )
						{
							yyyy += 1;
							mmm -= 12;
						}
					}
				}
				
				hh = (mm/60);
				mm = mm%60;
				
				//write
				cout << s.substr( 0, i );
				
				printf(	"[%02d/%3s/%04d:%02d:%02d:%02d %c%02d%02d]", 
						dd,month[mmm].c_str(),yyyy,hh,mm,ss, (timeZone)>0?'+':'-', abs(timeZone/60),abs(timeZone%60) );
					
				cout << s.substr( i+pattern.length(), s.length() ) << endl;
			}		
			if( check ) break;
		}
	}
}

void init()
{
	freopen( "apache.in", "r", stdin );
	freopen( "apache.out", "w", stdout );
	
	scanf("%d\n",&timeZone);
	timeZone = (timeZone/100)*60 + (timeZone%100);
}

int main()
{
	init();
	solve();
	return 0;
}
