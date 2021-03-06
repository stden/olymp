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
using namespace std;
int const N=55, M=305;
long long const inf=1000000000000000LL;
int n;
long long a[M], b[M], c[M];
long long r[1<<19], f[1<<18];
int lsf(int i, int j) {
	return r[i]<r[j];
}
struct graph {
	long long f[N][N], flow;
	pair<long long,long long> maxcut() {
		int p[N], q[N];
		for (int c=1<<30; c; c>>=1) 
			for(;;) {
				int b=0, e=0;
				memset(p, 0, sizeof p);
				p[1]=1, q[e++]=1;
				while(b!=e) {
					int k=q[b++];
					for (int i=1; i<=n; i++)
						if (!p[i] && f[k][i]>=c)
							p[i]=k, q[e++]=i;
				}
				if (!p[n])
					break;
				int cf=1<<30;
				for (int k=n; k!=1; k=p[k])
					if (cf>f[p[k]][k])
						cf=f[p[k]][k];
				for (int k=n; k!=1; k=p[k])
					f[p[k]][k]-=cf, f[k][p[k]]+=cf;
				flow+=cf;
			}
		memset(p, 0, sizeof p);
		int b=0, e=0;
		p[1]=1, q[e++]=1;
		while(b!=e) {
			int k=q[b++];
			for (int i=1; i<=n; i++)
				if (!p[i] && f[k][i]>0)
					p[i]=k, q[e++]=i;
		}
		long long msk=0;
		for (int i=1; i<=n; i++)
			msk+=(!p[i]<<i-1);
		return make_pair(flow, msk);
	}
};
int main () {
	freopen("cuts.in", "r", stdin);
	freopen("cuts.out", "w", stdout);
	int m;
	cin >> n >> m;
	for (int i=0; i<m; i++)
		cin >> a[i] >> b[i] >> c[i];
	if (n<=20) {
		for (int i=0; i<m; i++)
			a[i]--, b[i]--;
		int x=0;
		for (int i=1; i<(1<<n-1); i+=2) {
			for (int j=0; j<m; j++)
				if ((i>>a[j]&1) && !(i>>b[j]&1))
					r[i]+=c[j];
			f[x++]=i;
		}
		sort(f, f+x, lsf);
		int k; cin >> k;
		for (int i=0; i<k; i++, cout << endl)
			for (int j=0; j<n; j++)
				cout << 1-(f[i]>>j&1);
	}
	else {
		graph g; g.flow=0;
		memset(g.f, 0, sizeof g.f);
		for (int i=0; i<m; i++)
			g.f[a[i]][b[i]]+=c[i];
		map< pair<long long,long long>, set< pair<int,int> > > res;
		set< set< pair<int,int> > > w;
		res[g.maxcut()]=set<int>();
		for(int i=0; i<k; i++) {
			map< pair<long long,long long>, set<int> >::iterator j=res.begin();
			//cout << j->first.second << endl;
			graph cg=g;
			set< pair<int,int> > cs=j->second;
			for (set<int>::iterator i=cs.begin(); i!=cs.end(); i++)
				cg.f[i->first][i->second]=cg[i->second][i->first]=inf;
			
			
			
			
		}
	}
	return 0;
}
  