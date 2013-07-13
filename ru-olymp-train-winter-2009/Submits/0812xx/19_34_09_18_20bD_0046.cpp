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

struct F
{
	int ip;
	long long mask;
	string id_first,id_last;
	string to,pas;
	F()
	{
		mask = ((long long)1<<32)-1; 
	}
	F(int _ip, int _mask, string _to, string _id_first, string _id_last, string _pas )
	{
		ip = _ip;
		mask = (((long long)1<<_mask)-1) << (32-_mask);
		to = _to;
		id_first = _id_first;
		id_last = _id_last;
		pas = _pas;
	}
};

map <int,int> port;
F p[1000][50]; int p_size = 0;
int f_size[1000];

string s;
int it;

int getInt()
{
	while( it<(int)s.length() && !isdigit(s[it]) ) it++;
	int res = 0;
	while( it<(int)s.length() &&  isdigit(s[it]) )
	{
		res = res*10 + s[it]-'0';
		it++;
	}
	return res;
}
string nextStr()
{
	int i = it;
	while( i<(int)s.length() && ((s[i] == 32)||(s[i]==9)) ) i++;
	string res;
	while( i<(int)s.length() && s[i]!=32 && s[i]!=9 )
	{
		res += s[i];
		i++;
	}
	return res;
}
string getStr()
{
	while( it<(int)s.length() && ((s[it] == 32)||(s[it]==9)) ) it++;
	string res;
	while( it<(int)s.length() && s[it]!=32 && s[it]!=9 )
	{
		res += s[it];
		it++;
	}
	return res;
}

int main()
{
	freopen( "multiplexor.in", "r", stdin );
	freopen( "multiplexor.out", "w", stdout );
	
	int a,b,c,d,ip;
	getline( cin, s );
	it = 0;
	while( s[0] != '-' )
	{
		if( nextStr() == "A" )
		{
			p_size++;
			f_size[ p_size ] = 0;
			port[ getInt() ] = p_size;
		}
		if( nextStr() == "F" )
		{
			a = getInt();
			b = getInt();
			c = getInt();
			d = getInt();
			ip = (d<<0) | (c<<8) | (b<<16) | (a<<24);
			int mask = 32;
			if( s[it] == '/' )
			{
				mask = getInt();
			}
			string to;
			if( nextStr() == "T" )
			{
				getStr();
				to = getStr();
			}
			string id_first;
			string id_last; 
			if( nextStr() == "I" )
			{
				getStr();
				id_first = getStr();
				id_last = id_first;
				if( id_first.find("-")!=string::npos )
				{
					id_last = id_first.substr( id_first.find("-")+1, id_first.length() );
					id_first.resize( id_first.find("-") );
				}
			}
			string pas;
			if( nextStr() == "P" )
			{
				getStr();
				pas = getStr();
			}
			p[p_size][ f_size[p_size]++ ] = ( F( ip, mask, to, id_first, id_last, pas  ) );
		}
		
		
		getline( cin, s );
		it = 0;
	}
	
	while( getline( cin, s ) )
	{
		it = 0;
		if( nextStr() == "F" )
		{
			a = getInt();
			b = getInt();
			c = getInt();
			d = getInt();
			ip = (d<<0) | (c<<8) | (b<<16) | (a<<24);
			int n_port = 0;
			if(  nextStr() == "T" )
			{
				n_port = getInt();
			}
			string id;
			if( nextStr() == "I" )
			{
				getStr();
				id = getStr();
			}
			string pas;
			if( nextStr() == "P" )
			{
				getStr();
				pas = getStr();
			}
			int n_p = port[n_port];
			bool ok = false;
			for(int i=0; i < f_size[n_p]; i++)
			{
				F pr = p[n_p][i];
				ok = true;
				if( (pr.ip&pr.mask) != (ip&pr.mask) ) ok = false;
				if( pr.pas != "" &&  pr.pas != pas ) ok = false;
				
				if( pr.id_first != "" )
				{
					//id
					if( pr.id_first == pr.id_last )
					{
						if( pr.id_first != id ) ok = false;
					} else
					{
						if( pr.id_first.length() != id.length() ) ok = false;
						if( !(pr.id_first <= id && id <= pr.id_last) ) ok = false;
					}
				}
				
				if( ok )
				{
					cout << pr.to << endl;
					break;
				}	
			}
			if( !ok )
			{
				printf("/dev/null\n");
			}
			
		}
	}
	
	

	return 0;
}

