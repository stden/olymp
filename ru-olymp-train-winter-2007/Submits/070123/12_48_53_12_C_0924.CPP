#include <algorithm>
#include <fstream>
#include <iostream>
#include <map>
#include <queue>
#include <set>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <time.h>

using namespace std;

typedef long long LL;
typedef long double LD;
typedef vector<int> VI;
typedef vector<VI> VVI;
typedef vector<bool> VB;
typedef vector<string> VS;
typedef vector<LL> VLL;
typedef pair<int, int> PII;
typedef vector<PII> VPII;

int _stklen = 30 << 20;

#define F first
#define S second
#define PB push_back
#define MP make_pair

#define ALL(x) (x).begin(), (x).end()
#define SORT(x) sort(ALL(x))
#define SZ(x) (x).size()
#define VAR(x, y) typeof(y) x = (y)
#define ZERO(x) memset(x, 0, sizeof(x))

#define REPN(i, x) for (int i = 0; i < int(x); i++)
#define REPND(i, x) for (int i = int(x) - 1; i >= 0; i--)
#define REPS(i, x) REPN(i, SZ(x))
#define REPSD(i, x) REPND(i, SZ(x))
#define FOR(i, x, y) for (int i = int(x); i <= int(y); i++)
#define FORD(i, x, y) for (int i = int(x); i >= int(y); i--)
#define FORIT(i, x) for (VAR(i, (x).begin()); i != (x).end(); i++)
#define FORITD(i, x) for (VAR(i, (x).rbegin()); i != (x).rend(); i++)

template<class T> T sqr(T x) {
	return x * x;
}

#define MAXL 1500000
#define MAXN 4001
#define MAXQ 5000

int n;
char buf[MAXL];
bool g[MAXN][MAXN];
bool sbuf[6];
bool vhod[MAXN], vyhod[MAXN], incyc[MAXN];
VI cycle[MAXN + 1];

int code(char c) {
	if (c >= '0' && c <= '9') return c - '0';
	if (c >= 'A' && c <= 'Z') return c - 'A' + 10;
	if (c >= 'a' && c <= 'z') return c - 'a' + 36;
	if (c == '!') return 62;
	return 63;
}

int main() {
	freopen("tourism.in", "rt", stdin);
	freopen("tourism.out", "wt", stdout);
	scanf("%d\n", &n);
	gets(buf);
	int m = strlen(buf);
	int p = 0, q = 1;
	REPN(i, m) {
		int tmp = code(buf[i]);
		REPN(j, 6) {
			sbuf[j] = tmp % 2;
			tmp /= 2;
			if (p < n && q < n) {
				g[p][q] = sbuf[j];
				g[q][p] = 1 - g[p][q];
			}
			q++;
			if (q == n) {
				p++;
				q = p + 1;
			}
		}
	}
	cycle[1].PB(0);
	if (n >= 3) {
		ZERO(vhod);
		ZERO(vyhod);
		REPN(i, n) {
			if (g[0][i]) vyhod[i] = true;
			if (g[i][0]) vhod[i] = true;
		}
		REPN(i, n) {
			bool found = false;
			REPN(j, n) if (vyhod[i] && vhod[j] && g[i][j]) {
				found = true;
				cycle[3].PB(0);
				cycle[3].PB(i);
				cycle[3].PB(j);
				break;
			}
			if (found) break;
		}
		FOR(i, 4, n) {
			ZERO(incyc);
			REPS(j, cycle[i - 1]) incyc[cycle[i - 1][j]] = true;
			ZERO(vhod);
			ZERO(vyhod);
			REPN(j, n) REPN(k, n) {
				if (!g[j][k]) continue;
				if (!incyc[j] && incyc[k]) vhod[j] = true;
				if (incyc[j] && !incyc[k]) vyhod[k] = true;
			}
			bool done = false;
			REPN(j, n) if (vhod[j] && vyhod[j]) {
				REPN(k, i - 1) {
					if (g[cycle[i - 1][k]][j]
					    && g[j][cycle[i - 1][(k + 1) % (i - 1)]]) {
					    	REPN(ii, k + 1)	cycle[i].PB(cycle[i - 1][ii]);
					    	cycle[i].PB(j);
					    	FOR(ii, k + 1, i - 2) cycle[i].PB(cycle[i - 1][ii]);
						break;
					}
				}
				done = true;
				break;
			}
			if (done) continue;
			REPN(j, n) {
                                REPN(k, n) if (vhod[j] && vyhod[k] && g[k][j]) {
					cycle[i].PB(cycle[i - 1][0]);
					cycle[i].PB(k);
					cycle[i].PB(j);
					FOR(ii, 2, i - 2) cycle[i].PB(cycle[i - 1][ii]);
					done = true;
					break;
				}
				if (done) break;
			}
		}
	}
	scanf("%d", &m);
	REPN(i, m) {
		int b;
		scanf("%d", &b);
		if (b > n || SZ(cycle[b]) != b) {
			printf("-1\n");
			continue;
		}
		REPS(j, cycle[b]) printf("%d ", cycle[b][j]);
		printf("\n");
	}
	return 0;
}
