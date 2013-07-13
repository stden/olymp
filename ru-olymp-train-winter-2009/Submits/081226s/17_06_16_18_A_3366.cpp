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

const long double eps = 1e-4;

int n;
long double a[30][30];
bool used[30];
long double x[30];

int main()
{
	freopen( "linear.in", "r", stdin );
	freopen( "linear.out", "w", stdout );
	
	scanf( "%d", &n );
	for(int i=1; i<=n; i++)
	{
		for(int j=1; j<=n; j++)
		{
			int aij;
			scanf( "%d", &aij );
			a[i][j] = aij;
		}
		int b;
		scanf( "%d", &b );
		a[i][0] = b;
	}
	
	fill( used, false );
	
	for(int j=1; j<=n; j++)
	{
		double max = -1;
		int k = 0;
		for(int i=1; i<=n; i++)
			if( !used[i] && abs(a[i][j]) > max )
			{
				max = a[i][j];
				k = i;
			}
		used[k] = true;
		for(int i=1; i<=n; i++)
			if( i!=k )
			{
				double q = a[k][j]/a[i][j];
				for(int l=0; l<=n; l++) a[i][l] = a[i][l]*q-a[k][l];
			}
	}

	bool infinity = false;
	bool impossible = false;
	
	for(int i=1; i<=n; i++)
	{
		int k = 0;
		for(int j=1; j<=n; j++)
			if( abs(a[i][j]) > eps ) k = j;
			
		if( abs(a[i][0]) < eps && k == 0 ) infinity = true;
		if( abs(a[i][0]) > eps && k == 0 ) impossible = true;
		if( k != 0 ) x[k] = a[i][0] / a[i][k];
	}
	
	if( impossible )
	{
		printf("impossible\n");
	} else 
	if( infinity )
	{
		printf("infinity\n");
	} else
	{
		printf("single\n");
		cout.precision(20);
		for(int j=1; j<=n; j++) cout << x[j] << " ";
	}
	
	return 0;
}

