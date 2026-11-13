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
int const N=100005, NN=505;
int ne[N], pr[N];
long long w[N];
map< long long, set<int> > m;
list<int> s[N];
string res[N];
inline void madd(long long k, int c) {
	m[k].insert(c);
}
inline void mdel(long long k, int c) {
	map< long long, set<int> >::iterator i=m.find(k);
	i->second.erase(c);
	if (i->second.empty())
		m.erase(i);
}
long long xres[NN][NN], xs[NN];
long long const inf=1000000000000000000LL;
void rec(int x, int y) {
	for (int i=x; i<y; i++)
		if (xres[x][y]==xres[x][i]+xres[i+1][y]+xs[y]-xs[x-1]) {
			for (int j=x; j<=i; j++)
				res[j].push_back('0');
			for (int j=i+1; j<=y; j++)
				res[j].push_back('1');
			rec(x, i);
			rec(i+1, y);
			return;
		}
}
int main () {
	freopen("code.in", "r", stdin);
	freopen("code.out", "w", stdout);
	int n; scanf ("%d", &n);
	if (n<NN) {
		for (int i=1; i<=n; i++) {
			scanf ("%d", w+i);
			xs[i]=xs[i-1]+w[i];
		}
		for(int i=1; i<=n; i++)
			xres[i][i]=0;
		for (int k=1; k<n; k++)
			for (int i=1; i+k<=n; i++) {
				xres[i][i+k]=inf;
				for (int j=i; j<k; j++)
					if (xres[i][i+k]>xres[i][j]+xres[j+1][k]+xs[i+k]-xs[i-1])
						xres[i][i+k]=xres[i][j]+xres[j+1][k]+xs[i+k]-xs[i-1];
			}
		rec(1, n);
		for (int i=1; i<=n; i++)
			puts(res[i].c_str());
	}
	for (int i=1; i<=n; i++) {
		scanf ("%lld", w+i);
		s[i].push_back(i);
		pr[i]=i-1, ne[i]=i+1;
		if (i>1) madd(w[i-1]+w[i], i-1);
	}
	pr[0]=n, ne[0]=1, ne[n]=0;
	while(!m.empty()) {
		long long k=m.begin()->first, c=*(m.begin()->second.begin());
		for(list<int>::iterator i=s[c].begin(); i!=s[c].end(); i++)
			res[*i].push_back('0');
		for(list<int>::iterator i=s[ne[c]].begin(); i!=s[ne[c]].end(); i++)
			res[*i].push_back('1');
		s[c].splice(s[c].end(), s[ne[c]]);
		mdel(k, c);
		if (pr[c]) {
			mdel(w[pr[c]]+w[c], pr[c]);
			madd(w[pr[c]]+k, pr[c]);
		}
		if (ne[ne[c]]) {
			mdel(w[ne[c]]+w[ne[ne[c]]], ne[c]);
			madd(k+w[ne[ne[c]]], c);
		}
		w[c]+=w[ne[c]];
		pr[ne[ne[c]]]=c;
		ne[c]=ne[ne[c]];
	}
	for (int i=1; i<=n; i++) {
		reverse(res[i].begin(), res[i].end());
		printf ("%s\n", res[i].c_str());
	}
	cerr << clock() << endl;
	return 0;
}
  