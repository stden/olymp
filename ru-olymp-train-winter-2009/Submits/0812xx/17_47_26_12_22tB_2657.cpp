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
int const N=51, M=301;
long long const inf=0x003fffffffffffffLL, mxlong=0x3fffffffffffffffLL;
struct graph {
	int n;
	long long c[N][N], f[N][N], e[N], q[N], mncut;
	int h[N], a[N], w[N], st;
	string msk, res;
	void up(int &v) {
		int t=a[v];
		for (; v<st && h[a[v+1]]<h[t]; v++)
			a[v]=a[v+1];
		a[v]=t;
		memset(w, 0, sizeof w);
		for (int i=1; i<=n; i++)
			if (h[i]<n) 
				w[h[i]]=1;
		for (int i=1; i<n; i++)
			if (!w[i]) {
				for (int j=1; j<=n; j++)
					if (h[j]>i && h[j]<=n)
						h[j]=n+1;
				return;
			}
	}
	void push(int u, int v) {
		long long d=((e[u]>f[u][v]) ? f[u][v] : e[u]);
		f[u][v]-=d;
		f[v][u]+=d;
		e[u]-=d;
		e[v]+=d;
	}
	void relabel(int u) {
		h[u]++;
	}
	void discharge(int u) {
		for (int v=1; e[u]>0; v++) {
			if (v>n)
				relabel(u), v=1;
			if (f[u][v]>0 && h[u]==h[v]+1)
				push(u, v);
		}
	}
	void cut() {
		for (int u=2; u<=n; u++)
			h[u]=e[u]=0;
		h[1]=n, e[1]=mxlong;
		memcpy(f, c, sizeof c);
		for (int i=2; i<n; i++)
			if (msk[i-1]=='0') f[1][i]=inf;
			else if (msk[i-1]=='1') f[i][n]=inf;
		for (int v=2; v<=n; v++)
			push(1, v);
		st=0;
		for (int i=2; i<n; i++)
			a[++st]=i;
		for (int j=st; j; j--) {
			int hh=h[a[j]];
			discharge(a[j]);
			if (h[a[j]]>hh)
				up(j);
		}
		mncut=mxlong-e[1];
		memset(w, 0, sizeof w);
		int b=0, e=0;
		q[e++]=1, w[1]=1; 
		while(b<e) {
			int k=q[b++];
			for (int i=1; i<=n; i++)
				if (!w[i] && f[k][i]>0)
					w[i]=1, q[e++]=i;
		}
		res.resize(n);
		for (int i=0; i<n; i++)
			res[i]='1'-w[i+1];
	}
};
set< pair<long long, pair<string,string> > > st;
set<string> w;
int main () {
	freopen("cuts.in", "r", stdin);
	freopen("cuts.out", "w", stdout);
	int m;
	graph g;
	cin >> g.n >> m;
	g.msk.push_back('0');
	for (int i=2; i<g.n; i++)
		g.msk.push_back('*');
	g.msk.push_back('1');
	for (int i=0; i<m; i++) {
		long long a, b, v;
		cin >> a >> b >> v;
		g.c[a][b]=v;
	}
	g.cut();
	st.insert(make_pair(g.mncut, make_pair(g.msk, g.res)));
	w.insert(g.msk);
	int k=0; cin >> k;
	for (int i=0; i<k; i++) {
		string cur=st.begin()->second.first;
		string res=st.begin()->second.second;
		cout << res << endl;
		st.erase(st.begin());
		graph c; c.n=g.n;
		for (int i=0; i<g.n; i++)
			if(cur[i]=='*') {
				cur[i]=(res[i]=='1' ? '0' : '1');
				if (w.find(cur)==w.end()) {
					memcpy(c.c, g.c, sizeof g.c);
					c.msk=cur; 
					c.cut(); 
					w.insert(cur);
					st.insert(make_pair(c.mncut, make_pair(c.msk, c.res)));
				}
				cur[i]=res[i];
			}
	}
	return 0;
}