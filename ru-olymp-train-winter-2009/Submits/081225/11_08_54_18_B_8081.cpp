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

struct tlong 
{
	int a[150];
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
			a[++size] = x%10;
			x/=10;
		}while(x);
	}
	string toString()
	{
		string res;
		for(int i=size; i; i--)
			res += (char)(a[i]+'0');
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
		if( c.a[i] >= 10 )
		{
			c.a[i+1] += c.a[i]/10;
			c.a[i] %= 10;
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
		while( a.a[i] >= 10 )
		{
			a.a[i+1] += 1;
			a.a[i] -= 10;
		}
	}
	a.size = max(a.size,b.size)+2;
	while( a.size>1 && a.a[ a.size ] == 0 ) a.size--;
}

const int max_n = 500+3;
const int max_m = max_n;

typedef tlong int64;

int n,t;

int _r[max_n][max_m];
int64 _r_res[max_n][max_n];
int64 r(int n,int m)
{
	if( n < 0 || m < 0 ) return 0;
	if( _r[n][m] == (-1) )
	{
		_r[n][m] = 0;
		
		int64 res = 0;
		if( n==0 && m==0 )
		{
			res = 1;
		} else
		{
			for(int k1 = (t-1); k1 < (t*2); k1++)
				res += r(n-k1,m-1);
		}
		_r_res[n][m] = res;
	}	
	return _r_res[n][m];
}

int _s[max_n][max_n];
int64 _s_res[max_n][max_n];
int64 s(int k,int m)
{
	if( k < 0 || m < 0 ) return 0;
	if( _s[k][m] == (-1) )
	{
		_s[k][m] = 0;
		int64 res = 0;
		if( k==0 && m==0 )
		{
			res = 1;
		} else
		{
			for(int k1 = (t); k1 <= (t*2); k1++)
				res += s(k-k1,m-1);
		}
		_s_res[k][m] = res;
	}
	return _s_res[k][m];
}

int _f[max_n];
int64 _f_res[max_n];
int64 f(int n)
{
	if( n < t ) return 0;
	if( _f[n] == (-1) )
	{
		_f[n] = 0;
		int64 res = 0;
		if( t<=n && n <= (t*2) ) res = 1;
	
		for(int k=1; k<n; k++)
			res += s(n,k)*f(k);
		_f_res[n] = res;
	}
	return _f_res[n];
}

void solve()
{
	int64 res = 0;
	if( (t-1)<=n && n<=(t*2-1) ) res = 1;
	for(int k=1; k<=n; k++)
	{
		res += r(n,k)*f(k);
	}
	cout << res.toString();
	//printf("%d",res);
}

void init()
{
	freopen( "btrees.in", "r", stdin );
	freopen( "btrees.out", "w", stdout );
	
	scanf( "%d%d", &n, &t );
	
	fill( _r, -1 );
	fill( _s, -1 );
	fill( _f, -1 );
}

int main()
{
	init();
	solve();
	return 0;
}

