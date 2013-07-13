#include <cstdio>
#include <cstdlib>
#include <memory.h>
#include <algorithm>
#include <vector>

using namespace std;

#define TASKNAME "sum"
#define MAXN 100000

//#define DEBUG

typedef struct _tver {
  int val; short lor;
  _tver *p, *l , *r;
} *tver;

int n, glev, trc, M, h;
_tver buf[656000];
tver tree[5];


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

#define lval(x) ((x)->l ? ((x)->l)->val : 0)
#define rval(x) ((x)->r ? ((x)->r)->val : 0)

inline void plus1(int st) {
  vector<tver> pars(M + 1);
  vector<tver> vers(M + 1);
  for (int i = 0; i < M; i++) {
    vers[i] = tree[i];  
    
    int depth = 1;
    while ((1 << depth) <= st) depth++;
    for (int off = 1 << (depth - 2); off > 0; off >>= 1) {
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
    else tree[i + 1] = vers[i];
  if (pars[M])
    switch (vers[M - 1]->lor = lor0M) {
      case 0:pars[M]->l = vers[M - 1]; break;
      case 1:pars[M]->r = vers[M - 1]; break;
    }
  else tree[0] = vers[M - 1] ;
  for (int i = M; i >= 1; i--) vers[i] = vers[i - 1]; vers[0] = vers[M];
  for (int i = 0; i < M; i++) {
    tver v = vers[i]->p;
    while (v) {
      v->val = lval(v) + rval(v);
      v = v->p;
    }
  }
}

void plus1(int l, int r, int vid, int vl, int vr) {
  l = max(l, vl);
  r = min(r, vr);
  if (l > r) return;
  if ((l == vl) && (r == vr)) {plus1(vid); return;}
  plus1(l, r, vid << 1, vl, (vl + vr) >> 1);
  plus1(l, r, (vid << 1) + 1,
	 ((vl + vr) >> 1) + !!((vl + vr) & 1), vr);
}

int count_ontr(int l, int r, tver v, int vl, int vr) {
  l = max(l, vl);
  r = min(r, vr);
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

inline int count(int l, int r) {
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
      case 1:plus1(l, r, 1, 1, glev);
        //plus1(6);	
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