#include <iostream>
#include <algorithm>
#include <iomanip>
#include <functional>
#include <sstream>
#include <set>
#include <list>
#include <map>
#include <queue>
#include <ctime>
using namespace std;
int const N=2005;
long long const inf=1000000000000000LL;
int a[N];
long long s[N];
long long res[N][N];
string otv[N];
void rec(int x, int y) {
	for (int i=x; i<y; i++)
		if (res[x][y]==res[x][i]+res[i+1][y]+s[y]-s[x-1]) {
			for (int j=x; j<=i; j++)
				otv[j].push_back('0');
			for (int j=i+1; j<=y; j++)
				otv[j].push_back('1');
			rec(x, i);
			rec(i+1, y);
			return;
		}
}
int main () {
	freopen("code.in", "r", stdin);
	freopen("code.out", "w", stdout);
	int n; scanf ("%d", &n);
	for (int i=1; i<=n; i++) {
		scanf ("%d", a+i);
		s[i]=s[i-1]+a[i];
	}
	for(int i=1; i<=n; i++)
		res[i][i]=0;
	for (int k=1; k<n; k++)
		for (int i=1; i+k<=n; i++) {
			res[i][i+k]=inf;
			for (int j=i; j<k; j++)
				if (res[i][i+k]>res[i][j]+res[j+1][k]+s[i+k]-s[i-1])
					res[i][i+k]=res[i][j]+res[j+1][k]+s[i+k]-s[i-1];
		}
	rec(1, n);
	for (int i=1; i<=n; i++)
		puts(otv[i].c_str());
	return 0;
}
  