#include <cstdio>
#include <memory>
#define MaxN 20010
#define MaxM 200010
struct node{
	long j,num;
	node *n;} *G[MaxN], *tp;

int a,b,i,j,n,m,tm = 0;

long num[MaxN];

bool u[MaxN], br[MaxM];

int DFS(int i, int par){
	u[i] = true;
	num[i] = ++tm;
	node *p = G[i];
	int m = num[i];
	int t = 0;
	while (p != NULL) {
	 if (p->j != par){
	  if (!u[p->j]){
	  	t = DFS(p->j, i);
	  	if (t > num[i])
	  	 br[p->num] = true;
	  	if (t < m)
	  	 m = t;
	  }else{
	  	if (m > num[p->j])
	  		m = num[p->j];
	  }
	 }
	 p = p->n;
	}
	return m;
}

int main( void ){
 freopen("bridges.in", "rt", stdin);
 freopen("bridges.out", "wt", stdout);
 scanf(" %d %d ", &n, &m);
 for (i = 0; i<=n; i++) {
     G[i] = NULL;
     u[i] = false;
 }  
 for (i = 0; i<=m; i++) br[i] = false;
 for (i = 0; i < m; i++){
 	scanf(" %d %d ", &a, &b);
 	tp = new(node);
 	tp->j = a;
 	tp->num = i + 1;
 	tp->n = G[b];
 	G[b] = tp;
 	tp = new(node);
 	tp->j = b;
 	tp->num = i + 1;
 	tp->n = G[a];
 	G[a] = tp;
 }

 for (i = 1; i <= n; i++){
 	 if (!u[i])
 	  DFS(i,0);
 }
 j = 0;
 for (i = 1; i <= n; i++){
  if (br[i]) j++;
 }
 printf("%d\n", j);
 for (i = 1; i <= n; i++){
 	if (br[i]) printf("%d ", i);
 }
 return 0;          
}
