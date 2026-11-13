#include <iostream>
#include <algorithm>
#include <iomanip>
#include <functional>
#include <sstream>
#include <set>
#include <map>
#include <queue>
#include <memory.h>
#include <ctime>
using namespace std;
int const N=50, K=7, inf=0x3e3e3e3e;
int a[N][K], p[N][K], c[N][N];
int r[N][1<<K][101], n, k, v;
int rec(int x, int m=(1<<k)-1, int st=100) {
	if (!m) return 0;
	if (r[x][m][st]>=0)
		return r[x][m][st];
	r[x][m][st]=inf;
	for (int i=0; i<k; i++)
		if (m>>i&1)
			r[x][m][st]=min(r[x][m][st], rec(x, m^(1<<i), st-p[x][i])+a[x][i]*st);
	for (int i=0; i<k; i++)
		if (m>>i&1)
			for (int j=0; j<n; j++) {
				r[x][m][st]=min(r[x][m][st], rec(j, m^(1<<i))+a[x][i]*st+c[x][j]);
				if (x==v && m+1==(1<<k))
					r[x][m][st]=min(r[x][m][st], rec(j, m)+c[x][j]);
			}
	return r[x][m][st];
}
int main () {
    freopen("armor.in", "r", stdin);
    freopen("armor.out", "w", stdout);
    int m;
    cin >> n >> m >> k >> v; v--;
    for (int i=0; i<n; i++)
	  for (int j=0; j<k; j++) {
		cin >> a[i][j] >> p[i][j];
		a[i][j]/=100;
		if (!a[i][j])
		    a[i][j]=inf;
	  }
    memset(c, 0x3e, sizeof c);
    for (int i=0; i<m; i++) {
	  int p, q, z;
	  cin >> p >> q >> z;
	  p--, q--;
	  c[p][q]=min(c[p][q], z);
    }
    for(int k=0; k<n; k++)
		for (int i=0; i<n; i++)
			for (int j=0; j<n; j++)
				if (c[i][j]>c[i][k]+c[k][j])
					c[i][j]=c[i][k]+c[k][j];
	memset(r, -1, sizeof r);
	int res=rec(v);
	if (res==inf) cout << -1;
	else cout << res;
	return 0;
}
