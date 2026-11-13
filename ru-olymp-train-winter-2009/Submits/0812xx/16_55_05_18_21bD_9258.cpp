#include <iostream>
#include <cstring>
#include <string>
using namespace std;

string s;
string p = "dd-dd-dddd dd:dd:dd.dd";
string sConnection = "Connection established at";
string sHanging = "Hanging up the modem.";
string sClose = "Standard Modem closed.";
string sRead = " Reads";
string sWrite = " Writes";

struct data
{
	int mmm,dd,yyyy,hh,mm,ss,ms;
} start,finish;

int getInt(string s)
{
	int i = 0;
	while( i<(int)s.length() && !isdigit(s[i]) ) i++;
	int res = 0;
	while( i<(int)s.length() && isdigit(s[i]) )
	{
		res = res*10 + (int)(s[i]-'0');
		i++;
	}
	return res;
}

int main()
{
	freopen( "calls.in", "r", stdin );
	freopen( "calls.out", "w", stdout );
	
	int u,r,w;
	long long total_time = 0;
	long long total_pay = 0;
	long long total_r = 0;
	long long total_w = 0;
	bool open = false;
	
	while( getline( cin, s ) )
	{
		bool check = true;
		
		if( s.length() >= p.length() )
		{
			for(int i=0; i<(int)p.length(); i++)
			{
				if( p[i]=='d' && (!isdigit(s[i])) ) 
					check = false;
				if( p[i]!='d' && p[i] != s[i] ) 
					check = false;
			}
		} else check = false;
		
		if( check )
		{
			int mmm,dd,yyyy,hh,mm,ss,ms;
			sscanf(s.c_str(), "%d-%d-%d %d:%d:%d.%d",&mmm,&dd,&yyyy,&hh,&mm,&ss,&ms);
			
			if( s.find( sConnection ) != string::npos )
			{
				start.mmm = mmm;
				start.dd = dd;
				start.yyyy = yyyy;
				start.hh = hh;
				start.mm = mm;
				start.ss = ss;
				u = getInt(s.substr( s.find(sConnection)+sConnection.length(), s.length() ));
				open = true;
			}
			
			if( s.find( sHanging ) != string::npos )
			{
				finish.mmm = mmm;
				finish.dd = dd;
				finish.yyyy = yyyy;
				finish.hh = hh;
				finish.mm = mm;
				finish.ss = ss;
			}
			
			if( open && s.find( sRead ) != string::npos )
			{
				r = getInt(s.substr( s.find( sRead ) + sRead.length(), s.length() ));
			}
			if( open && s.find( sWrite ) != string::npos )
			{
				w = getInt(s.substr( s.find( sWrite ) + sWrite.length(), s.length() ));
			}
			
			if( open && s.find( sClose ) != string::npos )
			{
				int start_time = start.hh*60*60 + start.mm*60 + start.ss;
				int finish_time = finish.hh*60*60 + finish.mm*60 + finish.ss;
				int current_time = finish_time - start_time;
				if( current_time < 0 )
				{
					current_time += 24*60*60;
				}
				printf("%02d-%02d-%04d %02d:%02d:%02d   %d %d %d/%d\n",start.mmm,start.dd,start.yyyy,start.hh,start.mm,start.ss,current_time,u,r,w);
				
				total_time += current_time;
				if( current_time >= 60 )
				{
					total_pay += current_time;
				}
				total_w += w;
				total_r += r;
				open = false;
			}
		}
	}
	
	printf("Total seconds to pay = %lld, total seconds = %lld; total bytes %lld/%lld",total_pay,total_time,total_r,total_w);
	
	return 0;
}
