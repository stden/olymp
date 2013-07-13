#include <iostream>
#include <algorithm>
#include <iomanip>
#include <functional>
#include <sstream>
#include <set>
#include <map>
#include <queue>
#include <memory.h>
#include <list>
#include <cmath>
using namespace std;
int const N=20;
int f[N];
long double const eps=1e-6;
long double a[N][N+1];
long double res[N];
int main () {
	freopen("linear.in", "r", stdin);
	freopen("linear.out", "w", stdout);
	int n; cin >> n;
	for (int i=0; i<n; i++) {
		for (int j=0; j<=n; j++)
			cin >> a[i][j];
		f[i]=i;
	}
	for (int x=0; x<n; x++) {
		int k=x, l=x;
		for (int i=x; i<n; i++)
			for (int j=x; j<n; j++)
				if (fabsl(a[i][j])>fabsl(a[k][l]))
					k=i, l=j;
		if (fabsl(a[k][l])<=eps)
			break;
		for (int i=0; i<=n; i++)
			swap(a[x][i], a[k][i]);
		for (int i=0; i<n; i++)
			swap(a[i][x], a[i][l]);
		swap(f[x], f[l]);
		long double z=a[x][x];
		for (int i=0; i<=n; i++)
			a[x][i]/=z;
		for (int j=0; j<n; j++)
			if (j!=x) {
				z=a[j][x];
				for (int i=0; i<=n; i++)
					a[j][i]-=z*a[x][i];
			}
	}
	int ff=0;
	for (int i=0; i<n; i++) {
		int gg=1;
		for (int j=0; j<n; j++)
			if (fabsl(a[i][j])>eps)
				gg=0;
		if(gg) {
			if (fabsl(a[i][n])>eps) {
				cout << "impossible" <<endl;
				return 0;
			}
			ff=1;
		}
	}
	if (ff) {
		cout << "infinity" << endl;
		return 0;
	}
	cout << "single" << endl;
	for (int i=0; i<n; i++)
		res[i]=a[f[i]][n];
	for (int i=0; i<n; i++)
		cout << fixed << setprecision(6) << res[i] << ' ';
	return 0;
}
  