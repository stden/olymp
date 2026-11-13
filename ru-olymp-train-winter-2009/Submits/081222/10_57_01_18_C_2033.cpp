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

vector <int> v;

int solve(int n)
{
	static int a[32][32];
	int res = 0;
	
	for(int m=0; m < (1<<n); m++)
	{
		fill( a, 0 );
		for(int j = 0; j < n; j++)
			if( (m&(1<<j)) == 0 ) 
				a[0][j] = 'g';
			else
				a[0][j] = 'b';
		
		for(int j = 1; j < n; j++)
			for(int k = 0; k < (n-j); k++)
				if( a[j-1][k] == a[j-1][k+1] )
					a[j][k] = 'g';
				else
					a[j][k] = 'b';
			
		int resi = 0;
		for(int j=0; j<n; j++)
			for(int k=0; k<n; k++)
				if( a[j][k] == 'b' ) resi++;
			
		if( resi > res )
		{
			res = resi;
			v.clear();
			v.push_back( m );
		} else
		if( resi == res )
		{
			v.push_back( m );
		}
	}
	return res;
}

int solve2(int n)
{
	int res = 0;
	
	static vector <int> a,b;
	a.clear();
	
	for(int i=0; i<n; i++)
		if( (i%3) == 2 )
			a.push_back('g');
		else
			a.push_back('b');
		
	while( !a.empty() )
	{
		for(int i=0; i<(int)a.size(); i++)
			if( a[i] == 'b' ) res++;
		b.clear();
		for(int i=0; i<(int)a.size()-1; i++)
			if( a[i] == a[i+1] )
				b.push_back('g');
			else 
				b.push_back('b');
		swap(a,b);
	}
	return res;
}

long long solve3(int n)
{
	long long res = 1;
	long long d = 1;
	for(int i=2; i<=n; i++)
	{
		if( (i-2)%3 != 0 ) d++;
		res += d;
	}
	return res;
}

struct tlong
{
	int a[1000];
	int size;
	tlong(){}
	tlong(string s)
	{
		fill( a, 0 );
		size = (int)s.length();
		for(int i=0; i<(int)s.length(); i++)
			a[size-i] = s[i] - '0'; 
	}
	string toString()
	{
		string res;
		for(int i=size; i>=1; i--)
			res += (a[i]+'0');
		return res;
	} 
	int& operator[](int i)
	{
		return a[i];
	}
};
void operator+=(tlong& a,int b)
{
	int i = 1;
	a[1]+=b;
	while( a[i] >= 10 )
	{
		a[i]-=10;
		a[i+1]++;
		i++;
	}
	a.size = max(a.size,i);
}
tlong operator*(tlong a,tlong b)
{
	tlong c("0");
	c.size = a.size + b.size;
	for(int i=1; i<=a.size; i++)
		for(int j=1; j<=b.size; j++)
		{
			c[i+j-1] += a[i]*b[j];
		}
	for(int i=1; i<=c.size || c[i]!=0; i++)
	{
		c[i+1] += c[i]/10;
		c[i] %= 10;
	}
	while( c.size > 1 && c[ c.size ] == 0 ) c.size--;
	return c;
}
tlong operator/(tlong a,int b)
{
	tlong c("0");
	int tmp = 0;
	for(int i=a.size; i>=1; i--)
	{
		tmp = tmp*10 + a[i];
		c[i] = tmp/b;
		tmp %= b;
	}
	c.size = a.size;
	while( c.size > 1 && c[ c.size ] == 0 ) c.size--;
	return c;
}
int operator%(tlong a,int b)
{
	int tmp = 0;
	for(int i=a.size; i>=1; i--)
	{
		tmp = tmp*10 + a[i];
		tmp %= b;
	}
	return tmp;
}

string s;

tlong a,b,c,d;

int main()
{
	freopen( "room.in", "r", stdin );
	freopen( "room.out", "w", stdout );
	
	getline(cin,s);
	
	a = tlong(s);
	b = a;
	b += 1;
	c = a*b;
	//cout << c.toString() << " ";
	c = c/3;
	b += 1;
	if( b%3 == 0 ) c+=1;
	cout << c.toString();
	/*
	
	int n;
	scanf("%d",&n);
	//printf("%lld",solve3(n));
	*/
/*
	for(int i=1; i<=n; i++)
	{
		cout << i << " " << solve3(i) << " " <<  ((i)*(i+1))/3 << endl;
	}
*/
	/*
	for(int i=1; i<=n; i++)
	{
		printf("%d %lld\n",i,solve3(i));
		
		printf("%d = %d \n",i,solve(i));
		for(int j=0; j<(int)v.size(); j++)
		{
			for(int k=0; k<i; k++)
				printf("%c",((v[j]&(1<<k)) == 0)?'g':'b');
			printf(" ");
		}
		printf("\n\n");
		
	}
*/
	return 0;
}

