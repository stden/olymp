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

#define MAXN 100000

int n;
VI e1[MAXN], e2[MAXN];
int deg1[MAXN], deg2[MAXN], ma[MAXN], mb[MAXN];
queue<PII> q;

int main() {
	freopen("omax.in", "rt", stdin);
	freopen("omax.out", "wt", stdout);
	scanf("%d", &n);
	REPN(i, n) {
		int m;
		scanf("%d", &m);
		REPN(j, m) {
			int a;
			scanf("%d", &a);
			e1[i].PB(a - 1);
			e2[a - 1].PB(i);
		}
	}
	ZERO(deg1);
	ZERO(deg2);
	REPN(i, n) REPS(j, e1[i]) {
		deg1[i]++;
		deg2[e1[i][j]]++;
	}
	REPN(i, n) {
		if (deg1[i] <= 1) q.push(MP(i, 1));
		if (deg2[i] <= 1) q.push(MP(i, 2));
	}
	memset(ma, 255, sizeof(ma));
	memset(mb, 255, sizeof(mb));
	while (!q.empty()) {
		PII cur = q.front();
		q.pop();
		if (cur.S == 1) {
			if (ma[cur.F] != -1) continue;
			if (!deg1[cur.F]) {
				printf("NO\n");
				return 0;
			}
			REPS(i, e1[cur.F]) {
				if (mb[e1[cur.F][i]] == -1) {
					ma[cur.F] = e1[cur.F][i];
					mb[e1[cur.F][i]] = cur.F;
					REPS(j, e2[e1[cur.F][i]]) {
						deg1[e2[e1[cur.F][i]][j]]--;
						if (deg1[e2[e1[cur.F][i]][j]] <= 1)
							q.push(MP(e2[e1[cur.F][i]][j], 1));
					}
					break;
				}
			}
		}
		else {
			if (mb[cur.F] != -1) continue;
			if (!deg2[cur.F]) {
				printf("NO\n");
				return 0;
			}
			REPS(i, e2[cur.F]) {
				if (ma[e2[cur.F][i]] == -1) {
					mb[cur.F] = e2[cur.F][i];
					ma[e2[cur.F][i]] = cur.F;
					REPS(j, e1[e2[cur.F][i]]) {
						deg2[e1[e2[cur.F][i]][j]]--;
						if (deg2[e1[e2[cur.F][i]][j]] <= 1)
							q.push(MP(e1[e2[cur.F][i]][j], 2));
					}
					break;
				}
			}
		}
	}
	REPN(i, n) if (ma[i] == -1) {
		printf("NO\n");
		return 0;
	}
	printf("YES\n");
	REPN(i, n) printf("%d ", ma[i] + 1);
	printf("\n");
	return 0;
}
