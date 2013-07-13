#include <cstdio>
#include <memory>
#define MaxN 20010
#define MaxM 200010
struct node{
	long j,nu;
	node *n;} *G[MaxN], *tp;

long a,b,i,j,n,m,tm = 0;

long num[MaxN];

bool u[MaxN], br[MaxM];

long DFS(long i, long par){
	u[i] = true;
	num[i] = ++tm;
	node *p = G[i];
	long m = num[i];
	long t = 0;
	while (p != NULL) {
	 if (p->j != par){
	  if (!u[p->j]){
	  	t = DFS(p->j, i);
	  	if (t > num[i])
	  	 br[p->nu] = true;
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
 for (i = 0; i <= m; i++) br[i] = false;
 for (i = 0; i < m; i++){
 	scanf(" %d %d ", &a, &b);
 	tp = new(node);
 	tp->j = a;
 	tp->nu = i + 1;
 	tp->n = G[b];
 	G[b] = tp;
 	tp = new(node);
 	tp->j = b;
 	tp->nu = i + 1;
 	tp->n = G[a];
 	G[a] = tp;
 }
 DFS(i,0);
 
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
