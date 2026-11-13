#include <iostream>
#include <cstring>
#include <string>
#include <cmath>
#include <vector>
using namespace std;

struct tlong
{
	int a[500];
	int size;
	tlong()
	{
		size = 1;
		memset( a, 0, sizeof a );
	}
	tlong( string s )
	{
		memset( a, 0, sizeof a );
		size = (int)s.length();
		for(int i=0; i<(int)s.length(); i++)
		{
			a[size-i] = s[i] - '0';
		}
	}
	int& operator[](int i)
	{
		return a[i];
	}
	string toString()
	{
		string res;
		for(int i=size; i; i--)
		{
			res = res + (char)(a[i]+'0');
		}
		return res;
	}
};

tlong operator+( tlong a, int b )
{
	tlong c = a;
	c[1] += b;
	for(int i=1; c[i] >= 10; i++)
	{
		c[i+1] += c[i]/10;
		c[i] %= 10;
	}
	c.size = a.size + 10;
	while( c.size > 1 && c[ c.size ] == 0 ) c.size--;
	return c;
	return c;
}

tlong operator-( tlong a,tlong b )
{
	tlong c;
	for(int i=1; i<=a.size || i<=b.size || c[i] != 0; i++ )
	{
		c[i] += a[i]-b[i];
		while( c[i] < 0 )
		{
			c[i+1]-=1;
			c[i]+=10;
		}
	}
	c.size = max( b.size, a.size );
	while( c.size > 1 && c[ c.size ] == 0 ) c.size--;
	return c;
}

tlong operator*(tlong a,int b)
{
	tlong c;
	for(int i=1; i<=a.size; i++)
	{
		c[i] += a[i]*b;
		if( c[i] > 0 )
		{
			c[i+1] += c[i]/10;
			c[i] %= 10;
		}
	}
	c.size = a.size+2;
	while( c.size > 1 && c[ c.size ] == 0 ) c.size--;
	return c;
}

bool operator<=(tlong a, tlong b)
{
	if( a.size != b.size )
	{
		return a.size <= b.size;
	};
	for(int i = a.size; i; i--)
		if( a[i] != b[i] ) return a[i]<=b[i];
	
	return true;
}

tlong a,b;
vector <tlong> v1,v2;
tlong answer;
char out[1000][1000];
string s;

void printOut(int x,int y,string s)
{
	for(int i=0; i<(int)s.length(); i++)
		out[x][y+i] = s[i];
}

void solve()
{
	tlong tmp("0");
	for(int i=a.size; i; i--)
	{
		tmp = (tmp*10);
		tmp = tmp +a[i];
		//cout << tmp.toString() << endl;	
		int d = 0;
		for(int j=0; j<10; j++)
			if( b*j <= tmp ) d = j;
		v1.push_back( tmp );
		v2.push_back( b*d );
		tmp = tmp - b*d;
		answer = answer*10 + d;
	}
	v1.push_back( tmp );
	
	int s_ = 1,_s;
	bool empty = true;
	
	memset( out, 0, sizeof out );
	
	printOut(1,1,a.toString()+" |"+b.toString());
	s = "+";
	for(int i=1; i<=max(b.size,answer.size); i++)
		s += '-';
	printOut(2,a.size+2,s);
	printOut(3,a.size+2,"|"+answer.toString());
	
	int last = 2;
	
	for(int i=0; i<(int)v1.size()-1; i++ )
	{
		if( v2[i].toString() != "0" )
		{
			//---------
			_s = i+1;
			s.clear();
			for(int j=s_; j<=_s; j++) s += '-';
			//this number
			if( !empty )
			{
				printOut(last,s_,s);
				last++;
				printOut(last,i+1 - v1[i].size+1, v1[i].toString() );
				last++;
			}
			printOut(last,i+1 - v2[i].size+1, v2[i].toString() );
			last++;
			if( empty )
			{
				empty = false;
			} else
			{
				s_ = i+1-v1[i].size+1;
			}
		}
	}
	if( !empty )
	{
		int i = a.size;
		_s = i;
		s.clear();
		for(int j=s_; j<=_s; j++) s+='-';
		printOut(last,s_,s);
		last++;
		printOut(last,i-tmp.size+1,tmp.toString());
	}
	
	//print
	for(int i=1; i<1000; i++)
	{
		int end = 1000-1;
		while( end > 0 && out[i][end] == 0 ) end--;
		
		for(int j=1; j<=end; j++)
			printf("%c",out[i][j]==0?(' '):out[i][j]);
		
		if( end ) printf("\n");
	}
}

void init()
{
	freopen( "division.in", "r", stdin );
	freopen( "division.out", "w", stdout );
	
	string s;
	
	getline( cin, s );
	a = tlong( s );
	getline( cin, s );
	b = tlong( s );
}


int main()
{
	init();
	solve();
	return 0;
}

