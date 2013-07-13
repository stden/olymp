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
//#include "treeunit.h"
using namespace std;
#define mp make_pair 
int const N=200005;
int n, nn, a[N], b[N], f[N], w[N];
vector< pair<int,int> > g[N];
vector<int> nw;  
void initg() {
  memset(w, 0, sizeof w);
  memset(f, 63, sizeof f);
  for (int i=0; i<nw.size(); i++)
	  w[nw[i]]=-1;
}
int dfs(int k) {
  w[k]=1;
  int res=1;
  for (int i=0; i<g[k].size(); i++)
	if (!w[g[k][i].first]) {
	  int x=dfs(g[k][i].first);
	  f[g[k][i].second]=max(x, nn-x);
	  res+=x;
	}
  return res;
}
int main () {
  init();
  n=getN();
  for (int i=1; i<n; i++) {
	a[i]=getA(i);
	b[i]=getB(i);
	g[a[i]].push_back(mp(b[i], i));
	g[b[i]].push_back(mp(a[i], i));
  }
  int z=1;
  initg();
  for (nn=dfs(z);;nn=dfs(z)) {
	if (nn==1) {
	  cerr << clock();
	  report(z);
	  return 0;
	}
	initg();
	dfs(z);
	int mn=n, k=0;
	for (int i=1; i<n; i++)
	  if (f[i]<mn)
		mn=f[i], k=i;
	if (query(k)) {
	  z=b[k]; nw.push_back(a[k]);	  
	}
	else {
	  z=a[k]; nw.push_back(b[k]);
	}
	initg();
  }
  return 0;
}
  