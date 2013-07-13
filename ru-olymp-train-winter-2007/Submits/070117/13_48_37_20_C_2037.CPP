#include <algorithm>
#include <vector>
#include <math.h>
#include <set>
#include <map>

#include <cstdio>
#include <cstring>
#include <iostream>

using namespace std;

#define SZ(x) 
#define PB push_back
#define LL long long
#define MP make_pair

#define REPN(i, x) for (int i=0;i<x;i++)
#define REPS(i, x) REPN(i, SZ(x))
#define FOR(i, p, q) for (int i=p;i<q;i++)

int main() {
	freopen("restore.in", "r", stdin);
	freopen("restore.out", "w", stdout);
	int n, m, hmod;
	scanf("%d%d%d", &n, &m, &hmod);
	int g[30][30];
	REPN(i, n) REPN(j, n) g[i][j] = 0;
	REPN(i, m) {
		int a, b;
		scanf("%d%d", &a, &b);
		a--;
		b--;
		g[a][b] = 1;
		g[b][a] = 1;
        }
        int s;
        scanf("%d", &s);
        s--;
        int r, l;
        int q[30];
        int d[30];
        
        REPN(i, n) d[i] = n + 1;
        r = 1;
        q[0] = s;
        l = 0;
        d[s] = 0;
        while (l < r) {
        	int x;
        	x = q[l];
        	l++;
        	REPN(i, n) 
        		if ((g[x][i] == 1) && (d[i] > d[x] + 1)) {
        			d[i] = d[x] + 1;
        			q[r] = i;
        			r++;
        		}
        }
        int nt;
        LL ca[30], cb[30];
	LL gg[2][30][30], gc[2][30][30];
        REPN(i, n) ca[i] = 1;
        scanf("%d", &nt);
        REPN(it, nt) {
        	int a, b;
        	scanf("%d%d", &a, &b);
        	REPN(i, n) cb[i] = 0;
        	REPN(i, n) REPN(j, n) cb[i] += (ca[j] * g[i][j] * (d[i] == a)) % hmod;
        	REPN(i, n) ca[i] = cb[i];
        	b--;
        	if (b != 0) {
        		REPN(i, n) REPN(j, n) gg[0][i][j] = g[i][j] * (d[i] == a) * (d[j] == a);
        		REPN(i, n) REPN(j, n) gc[0][i][j] = 0;
        		REPN(i, n) gc[0][i][i] = 1;
        		int kc, kg;
        		kc = 0;
        		kg = 0;
        		while (b != 0) {
        			if (b % 2 == 1) {
        				REPN(i, n) REPN(j, n) {
        					gc[1 - kc][i][j] = 0;
        					REPN(k, n) {
        						gc[1 - kc][i][j] += gc[kc][i][k] * gg[kg][k][j];
        						gc[1 - kc][i][j] %= hmod;
        					}	
        				}
        				kc = 1 - kc;
        			}
        			REPN(i, n) REPN(j, n) {
        				gg[1 - kg][i][j] = 0;
        				REPN(k, n) {
        					gg[1 - kg][i][j] += gg[kg][i][k] * gg[kg][k][j];
        					gg[1 - kg][i][j] %= hmod;
        				}                                                     
             			}
        			kg = 1 - kg;
        			b = b / 2;
        		}
        		REPN(i, n) cb[i] = 0;
	        	REPN(i, n) REPN(j, n) {
        			cb[i] += ca[j] * gc[kc][i][j];
        			cb[i] %= hmod;
        		}
        	}
        	REPN(i, n) ca[i] = cb[i];
        	LL ans = 0;
        	REPN(i, n) {
        		ans += ca[i];
        		ans %= hmod;
        	}
        }
       	LL ans = 0;
       	REPN(i, n) {
       		ans += ca[i];
       		ans %= hmod;
      	}
      	printf("%Ld", ans);

}
