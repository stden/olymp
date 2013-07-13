#include <cstdio>
#include <cstdlib>
#include <memory.h>
#include <algorithm>
#include <vector>
#include <queue>
#include "treeunit.h"

using namespace std;

#define MAXN 200000

int n;
vector< pair<int, int> > eds[MAXN];
struct tver {
  int par; short paris; int edn;
  int size;
} ver[MAXN];
bool used[MAXN]; int root;
int q[MAXN]; int qb = 0, qe = 0;

int findedge() {
  int min = 1000000, maxi = root;
  for (int i = 0; i < n; i++)
    if (used[i] && (i != root)) {
      int cur = abs(n - (ver[i].size << 1));
      if (cur < min) {min = cur; maxi = i;}
    }
  return maxi;
}

vector<bool> calctree(int st) {
  vector<bool> res(n, false);
  
  queue<int> que;
  que.push(st); res[st] = true;
  while (!que.empty()) {
    int i = que.front(); que.pop();
    for (int i2 = 0; i2 < eds[i].size(); i2++)
      if (!res[eds[i][i2].first] && used[eds[i][i2].first])
	if (eds[i][i2].first != ver[i].par) {
	  que.push(eds[i][i2].first);
	  res[ eds[i][i2].first ] = true;
	}
  }
  return res;
}

int main() {
  init();
  n = getN();
  
  for (int i = 1; i < n; i++) {
    int a = getA(i), b = getB(i);
    a--, b--;
    eds[a].push_back(make_pair(b, i));
    eds[b].push_back(make_pair(a, -i));
  }
  
  q[qb] = 0;
  vector<bool> was(n, false);
  
  ver[0].par = -1; ver[0].size = 1; was[0] = true;
  for (; qb <= qe; qb++) {
    int i = q[qb];
    for (int i2 = 0; i2 < eds[i].size(); i2++)
      if (!was[eds[i][i2].first]) {
	int x = eds[i][i2].first;
	ver[x].par = i;
	if (eds[i][i2].second > 0) ver[x].paris = 1;
	else ver[x].paris = 0;
	ver[x].edn = abs(eds[i][i2].second);
	ver[x].size = 1;
	q[++qe] = x; was[x] = true;
      }    
  }
  for (int i = qe; i >= 0; i--)
    if (ver[q[i]].par >= 0) ver[ver[q[i]].par].size += ver[q[i]].size;
  
  memset(used, 0x01, sizeof used);
  root = 0;
  
  int curv;
  while ((curv = findedge()) != root) {
    int res = query(ver[curv].edn);
    res ^= ver[curv].paris;
    
    vector<bool> tree = calctree(curv);
    /*printf("=%d\n", res);
    printf("Subtree of %d:", curv + 1);
    for (int i = 0; i < n; i++) if (tree[i]) printf(" %d", i + 1);
    printf("\n\n");*/
    switch (res) {
      case 0: //Оставляем только себя и своё поддерево
	for (int i = 0; i < n; i++)
	  used[i] = used[i] && tree[i];
	root = curv;
	break;
      case 1: //Отрезаем себя и своё дерево	
	for (int i = 0; i < n; i++)
	  used[i] = used[i] && !tree[i];	
	break;
    }
  }
  report(root + 1);
  
  return 0;
}