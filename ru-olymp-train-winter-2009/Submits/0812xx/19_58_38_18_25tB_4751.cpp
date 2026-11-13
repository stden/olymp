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

const int base = 10000;

struct tlong 
{
	int a[60];
	int size;
	tlong()
	{
		fill( a, 0 );
		size = 1;
	}
	tlong(int x)
	{
		fill( a, 0 );
		size = 0;
		do
		{
			a[++size] = x%base;
			x/=base;
		}while(x);
	}
	string toString()
	{
		string res;
		char s[8];
		for(int i=size-1; i; i--)
		{
			int x = a[i];
			sprintf(s,"%04d",x);
			res += string(s);
			
		}
		sprintf(s,"%d",a[size]);
		res = string(s) + res;
		return res;
	}
};

tlong operator*(const tlong &a,const tlong &b)
{
	tlong c;
	for(int i=1; i<=a.size; i++)
		for(int j=1; j<=b.size; j++)
		{
			c.a[i+j-1] += a.a[i]*b.a[j];
		}
	c.size = a.size+b.size;
	for(int i=1; i<=c.size; i++)
	{
		if( c.a[i] >= base )
		{
			c.a[i+1] += c.a[i]/base;
			c.a[i] %= base;
		}
	}
	while( c.size > 1 && c.a[ c.size ] == 0 ) c.size--;
	return c;
}
void operator+=(tlong &a,const tlong &b)
{
	for(int i=1; i<=a.size || i<=b.size || a.a[i] != 0; i++)
	{
		a.a[i] += b.a[i];
		while( a.a[i] >= base )
		{
			a.a[i+1] += 1;
			a.a[i] -= base;
		}
	}
	a.size = max(a.size,b.size)+2;
	while( a.size>1 && a.a[ a.size ] == 0 ) a.size--;
}

const int max_n = 500+3;
const int max_m = max_n;

typedef tlong int64;

int n,t;

bool _r[max_n][max_m];
int64 _res[max_n][max_n];
int64 r(int n,int m)
{
	if( n < 0 || m < 0 ) return 0;
	if( !_r[n][m] )
	{
		_r[n][m] = true;
		
		if( n==0 && m==0 )
		{
			_res[n][m] = 1;
		} else
		{
			for(int k1 = (t-1); k1 < (t*2); k1++)
				_res[n][m] += r(n-k1,m-1);
		}
	}	
	return _res[n][m];
}

bool _s[max_n][max_n];
int64 s(int k,int m)
{
	if( k < 0 || m < 0 ) return 0;
	if( !_s[k][m] )
	{
		_s[k][m] = true;
		
		_res[k][m] = 0;
		if( k==0 && m==0 )
		{
			_res[k][m] = 1;
		} else
		{
			for(int k1 = (t); k1 <= (t*2); k1++)
				_res[k][m] += s(k-k1,m-1);
		}
	}
	return _res[k][m];
}

bool _f[max_n];
int64 _f_res[max_n];
int64 f(int n)
{
	if( n < t ) return 0;
	if( !_f[n] )
	{
		_f[n] = true;
		
		if( t<=n && n <= (t*2) ) _f_res[n] = 1;
	
		for(int k=t; k<n; k++)
			_f_res[n] += s(n,k)*f(k);
		
	}
	return _f_res[n];
}

int64 _r_res[max_n];
void solve()
{
	for(int i=t; i<=n; i++)
	{
		_r_res[i] = r(n,i);
	}
	
	int64 res = 0;
	if( (t-1)<=n && n<=(t*2-1) ) res = 1;
	
	for(int k=t; k<=n; k++)
	{
		res += _r_res[k]*f(k);
	}
	cout << res.toString();
}

void init()
{
	freopen( "btrees.in", "r", stdin );
	freopen( "btrees.out", "w", stdout );
	
	scanf( "%d%d", &n, &t );
	
	fill( _r, false );
	fill( _s, false );
	fill( _f, false );
}

int main()
{
	init();
	solve();
	return 0;
}

