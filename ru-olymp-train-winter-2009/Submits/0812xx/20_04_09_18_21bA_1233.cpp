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

int it = 0;
string s;

string getStr()
{
	while( it<(int)s.length() && (s[it]==9||s[it]==' ') ) it++;
	string res;
	while( it<(int)s.length() && !(s[it]==9||s[it]==' ') )
	{
		res += s[it++];
	}
	return res;
}
int getInt()
{
	string s = getStr();
	if( s == "-" ) return -1;
	int res = 0;
	if( s.find("0x")!=string::npos )
	{
		sscanf(s.c_str(),"%x",&res);
	} else
	{
		sscanf(s.c_str(),"%d",&res);
	}
	return res;
}

const int max_n = 1000;
int n = 2;
int a[max_n][max_n];
map < string,int > m;

int vertex(string s)
{
	if( m[s] == 0 )
	{
		m[s] = ++n;
		a[1][n] = -1;
		a[n][2] = -1;
	} 
	return m[s];
}

void relax_edge(int x,int y,int mask)
{
	a[x][y] = mask;
}

int answer[max_n];
int idDfs = 0;
int was[max_n];
int end;

int dfs_visit(int i)
{
	if( i == end ) return -1;
	was[i] = 1;
	//if( was[i] != idDfs )
	//{
		//was[i] = idDfs;
		//answer[i] = 0;
		int res = 0;
		
		for(int j=1; j<=n; j++)
		if( a[i][j] != 0 && was[i] == 0 )
			res |= a[i][j] & dfs_visit(j);
		
		answer[i] = res;
	//}
	was[i] = 0;
	return answer[i];
}

int dfs(int src, int dest)
{
	fill( answer, 0 );
	//answer[ dest ] = -1;
	//was[ dest ] = idDfs+1;
	//idDfs++;
	end = dest;
	return dfs_visit(src);
}

void solve()
{
	fill( was, 0 );

	while( getline( cin, s ) )
	{
		it = 0;
		getInt();
		string ind = getStr();
		string up = getStr();
		if( ind == "RIGHTS" )
		{
			string s1 = getStr();
			string s2 = getStr();
			int src = vertex( s1 );
			int dest = vertex( s2 );
		
			int r = dfs( src, dest );
			int res = 0;
			for(int i=0; i<=7; i++)
			{
				int mask = ((1<<4)-1) << (i*4);
				int x = ( r & mask) >> (i*4);
				if( (i%2) == 0 )
				{
					res = res | x;
				} else
				{
					res = res & (~x);
				}
			}
			cout << s1 << " has ";
			if( res==0 ) printf("no");
			if( res&8 ) printf("A");
			if( res&4 ) printf("R");
			if( res&2 ) printf("W");
			if( res&1 ) printf("X");
			
			cout << " rights on " << s2 << "." << endl;
			//out
		}//rights
		if( ind.find( "GR" )!=string::npos )
		{
			string s1 = getStr();
			int src = vertex( s1 );
			int mask = getInt();
			
			string s2 = getStr();
			while( s2 != "" )
			{
				int dest = vertex( s2 );
				if( src != 1 && dest != 2 )
				{
					if( ind[0] == '+' )
					{
						relax_edge( src, dest, a[src][dest]|mask );
					} else
					if( ind[0] == '-' )
					{
						relax_edge( src, dest, a[src][dest]&(~mask) );
					} else
					if( ind[0] == '=' )
					{
						relax_edge( src, dest, mask );
					}
				}
				s2 = getStr();
			}//while
		}//GR
		if( ind.find( "RG" )!=string::npos )
		{
			string s1 = getStr();
			int dest = vertex( s1 );
			int mask = getInt();
			
			string s2 = getStr();
			while( s2 != "" )
			{
				int src = vertex( s2 );
				if( src != 1 && dest != 2 )
				{
					if( ind[0] == '+' )
					{
						relax_edge( src, dest, a[src][dest]|mask );
					} else
					if( ind[0] == '-' )
					{
						relax_edge( src, dest, a[src][dest]&(~mask) );
					} else
					if( ind[0] == '=' )
					{
						relax_edge( src, dest, mask );
					}
				}//if
				s2 = getStr();
			}//while
		}//RG
	}//while s
}

void init()
{
	freopen( "tts.in", "r", stdin );
	freopen( "tts.out", "w", stdout );
	
	m[ "initial" ] = 1;
	m[ "final" ] = 2;
	fill( a, 0 );
	a[1][2] = -1;
}

int main()
{
	init();
	solve();
	return 0;
}

