#define _CRT_SECURE_NO_DEPRECATE

#include <iostream>
#include <fstream> 
#include <sstream>
#include <string>
#include <vector>
#include <algorithm>
#include <cstdio>
#include <cstdlib>
#include <utility>
#include <cmath>
#include <ctime>                      
#include <cctype>
#include <map>
#include <set>
#include <list>
#include <queue>
#include <stack>
#include <deque>

using namespace std;

typedef long long int64;


#define forn(i, n) for (int i = 0; i < (int)(n); i++)
#define ford(i, n) for (int i = (int)(n) - 1; i >= 0; i--)
#define fs first
#define sc second
#define mp make_pair
#define pb push_back
#define pf push_forward
#define last(a) (int)a.size() - 1
#define all(a) a.begin(), a.end()
#define VI vector<int>
#define PII pair<int,int>
#define add botva

const int NMAX=60;

const int64 INF=(int64)1e11;

struct xep{
	int64 vec;
	vector<char> a,b;
	};
	
bool operator < (xep a,xep b){
	if(a.vec!=b.vec)return a.vec<b.vec;
	if(a.a!=b.a)return a.a<b.a;
	return a.b<b.b;	
	};	
	



int n,m; //vertex number
int s, t; // source, destination
VI h, pos; // height, water, position
vector<int64> w;
int64 c[NMAX][NMAX], f[NMAX][NMAX], g[NMAX][NMAX]; // capacity, flow
bool used[NMAX];

void pushFlow(int a, int b) {
	if (h[a] <= h[b]) return ;
	int64 to = min(w[a], c[a][b] - f[a][b]);
	w[a] -= to; w[b] += to;
	f[a][b] += to; f[b][a] -= to;
}
void init() {
	h = pos = VI(n, 0);
	w = vector<int64> (n, 0);
	h[s] = n; w[s] = n*INF;
	forn(i,n)
		forn(j,n)f[i][j]=0;
	forn(i, n) pushFlow(s, i);
}
void up(int v) {
	while (pos[v] < n) {
		pushFlow(v, pos[v]);
		if (w[v] == 0) return ;
		++pos[v];
	}
	pos[v] = 0;
	++h[v];
}
void flow() {
	init();
	while (1) {
		int c = -1;
		forn(i, n) if (i != s && i != t && w[i] > 0) {
			if (c == -1 || h[c] < h[i]) c = i;
			}
		if (c == -1) break;

		up(c);
		}
	}

void go(int v){
	used[v]=0;
	forn(i,n)
		if(used[i]==1 && c[v][i]-f[v][i]>0)go(i);

	};

set < xep >  u;



void add(vector<char> a){
	xep b;
	b.a=a;
	forn(i,n)
		forn(j,n)c[i][j]=g[i][j];


	forn(i,n)
		if(a[i]==0 && i>0)c[0][i]=INF;else
		if(a[i]==1 && i<n-1)c[i][n-1]=INF;
	flow();

	b.vec=w[n-1];

	forn(i,n)
		used[i]=1;
	go(0);
	b.b.resize(n);
	forn(i,n)
		b.b[i]=used[i];
	u.insert(b);
	}                                       

int main(){
	freopen("cuts.in","rt",stdin);
	freopen("cuts.out","wt",stdout);
	cin>>n>>m;
	
	s=0;
	t=n-1;

	forn(i,n)
		forn(j,n)
			g[i][j]=0;
	forn(i,m){
		int64 u,v,w;
		cin>>v>>u>>w;
		g[--v][--u]+=w;

		}

	int64 kol;
	cin>>kol;

	vector<char> now(n),best;
	forn(i,n)now[i]=-1;
	now[0]=0;
	now[n-1]=1;
	add(now);

 	forn(i,kol){
		now=u.begin()->a;
		best=u.begin()->b;
		forn(j,n)
			printf("%d",best[j]);

		printf("\n");
		u.erase(u.begin());
		forn(j,n)
			if(now[j]==-1){
				now[j]=best[j] ^ 1;
				add(now);
				now[j]=best[j];
				}
	       	}

       return 0;


       };



		