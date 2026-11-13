#include <cstdio>
#include <cstdlib>
#include <memory.h>
#include <algorithm>
#include <vector>

using namespace std;

#define TASKNAME "sums"
#define MAXN 100000

//#define DEBUG

typedef struct _tver {
  int val; short lor;
  _tver *p, *l , *r;
} *tver;

int n, glev, trc, M, h;
_tver buf[1500000];
tver tree[5];

#define a ++% M (a = (a + 1) % M)
#define lval(x) ((x)->l ? ((x)->l)->val : 0)
#define rval(x) ((x)->r ? ((x)->r)->val : 0)

void plus1(int st) {
  vector<tver> pars(M + 1);
  vector<tver> vers(M + 1);
  for (int i = 0; i < M; i++) {
    vers[i] = tree[i];    
    for (int off = (1 << h) >> 2; off > 0; off >>= 1) {
      if (st & off) vers[i] = vers[i]->r;
      else vers[i] = vers[i]->l;
    }
    pars[i] = vers[i]->p;
  }
  pars[M] = pars[0]; vers[M] = vers[0];
  for (int i = 0; i < M; i++) vers[i]->p = pars[i + 1];
  int lor0M = vers[M]->lor;
  for (int i = 0; i < M; i++)
    if (pars[i + 1])
      switch (vers[i]->lor = vers[i + 1]->lor) {
	case 0:pars[i + 1]->l = vers[i]; break;
	case 1:pars[i + 1]->r = vers[i]; break;
      }
  if (pars[M])
    switch (vers[M - 1]->lor = lor0M) {
      case 0:pars[M]->l = vers[M - 1]; break;
      case 1:pars[M]->r = vers[M - 1]; break;
    }
  for (int i = M; i >= 1; i--) vers[i] = vers[i - 1]; vers[0] = vers[M];
  for (int i = 0; i < M; i++) {
    tver v = vers[i]->p;
    while (v) {
      v->val = lval(v) + rval(v);
      v = v->p;
    }
  }
}

int count_ontr(int l, int r, tver v, int vl, int vr) {
  l = max(l, vl);
  r = min(r, vr);
  #ifdef DEBUG
  printf("%d, %d, %d, %d\n", l, r, vl, vr);
  #endif
  if (l > r) return 0;
  if ((l == vl) && (r == vr)) return v->val;
  int ans = 0;
  if (v->l)
    ans += count_ontr(l, r, v->l, vl, (vl + vr) >> 1);
  if (v->r)
    ans += count_ontr(l, r, v->r,
		       ((vl + vr) >> 1) + !!((vl + vr) & 1), vr);
  return ans;
}

int count(int l, int r) {
  int ans = 0;
  for (int i = 1; i < M; i++) {
    int cur = count_ontr(l, r, tree[i], 1, glev);
    #ifdef DEBUG
    printf("%d: f(%d-%d) = %d\n", i, l, r, cur);
    #endif
    ans += cur * i;
  }
  return ans;
}

#ifdef DEBUG
vector< pair<tver, int> > q;
void printtree(tver rt) {
  q = vector< pair<tver, int> >(trc);
  int qb = 0, qe = 0; q[0] = make_pair(rt, 0);
  int lastdist = -1;
  
  while (qb <= qe) {
    tver i = q[qb].first;
    if (lastdist < q[qb].second) printf("\n%d: ", q[qb].second);
    lastdist = q[qb].second;
    printf(" %d", i->val);
    
    if (i->l) q[++qe] = make_pair(i->l, q[qb].second + 1);
    if (i->r) q[++qe] = make_pair(i->r, q[qb].second + 1);
    qb++;     
  }
}
#endif

int main() {
  freopen(TASKNAME ".in", "r", stdin);
  freopen(TASKNAME ".out", "w", stdout);
  
  int m;
  scanf("%d%d%d", &n, &M, &m);  
  
  glev = 1; h = 1; while (glev < n) glev <<= 1, h++;
  trc = glev << 1;
  
  memset(buf, 0, sizeof buf);
  int frmem = 0;
  for (int cur = 0; cur < M; cur++) {
    tree[cur] = &buf[frmem];
    for (int i = 1; i < glev; i++) {
      buf[frmem].val = 0;
      if (i > 1) {
	buf[frmem].p = &buf[frmem -i + (i >> 1)];
	buf[frmem].lor = (i & 1);
      }
      buf[frmem].l = &buf[frmem + i];
      buf[frmem].r = &buf[frmem + i + 1];
      frmem++;
    }
    for (int i = glev; i < trc; i++) {
      buf[frmem].p = &buf[frmem - i + (i >> 1)];
      buf[frmem].lor = (i & 1);
      frmem++;
    }
  }
  for (int i = glev; i < glev + n; i++) buf[i - 1].val = 1;
  for (int i = glev - 1; i >= 1; i--)
    buf[i - 1].val = lval(&buf[i - 1]) + rval(&buf[i - 1]);
  for (int i = 0; i < m; i++) {
    int act, l, r;
    scanf("%d%d%d", &act, &l, &r);    
    switch (act) {
      case 1:
	l += glev - 1; r += glev - 1;
	for (int i = l; i <= r; i++) plus1(i);
	#ifdef DEBUG
	for (int i = 0; i < M; i++) {
	  printf("Tree #%d:", i); printtree(tree[i]);
	  printf("\n");
	}
	#endif	
	break;
      case 2:printf("%d\n", count(l, r)); break;
    }
  }
  return 0;
}