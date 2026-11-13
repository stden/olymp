#include <iostream>
#include <cassert>
#include <cmath>
#include <string>
#include <cstring>
#include <vector>
#include <fstream>
#include <algorithm>
#include <cstdio>
#include <ctime>
#include <cstdlib>
#include <set>
#include <map>
#include <iomanip>
#define nextLine() { for (int c = getchar(); c != '\n' && c != EOF; c = getchar()); }
#define sqr(a) ((a)*(a))
#define has(mask,i) (((mask) & (1<<(i))) == 0 ? false : true)
#define eprintf(...) fprintf(stderr, __VA_ARGS__)
#define TASK "odd"
using namespace std;

#define pii pair<int,int>
#define mp make_pair
#define pb push_back
#define fi first
#define se second

#if ( _WIN32 || __WIN32__ )
    #define LLD "%I64d"
#else
    #define LLD "%lld"
#endif

typedef long long LL;
typedef long double ldb;
typedef vector <int> vi;
typedef vector <vi> vvi;
typedef vector <bool> vb;
typedef vector <vb> vvb;

const int INF = (1 << 30) - 1;
const ldb EPS = 1e-9;
const ldb PI = fabs(atan2(0.0, -1.0));
const int MAXV = 300001;
const int MAXE = 600001;

int n, m;
vector <pii> g[MAXV];
void load()
{
	scanf("%d%d", &n, &m);
	for (int i = 0, u, v; i < m; i++)
	{
		scanf("%d%d", &u, &v);
		--u, --v;
		g[u].pb(mp(v, i));
		g[v].pb(mp(u, i));
	}
}

int fst[MAXV];
int nxt[MAXE];
int eend[MAXE];
int deg[MAXE];
int edgeId[MAXE];
int type[MAXE];
int edges = 0;

inline void addEdge(int u, int v, int id)
{
	deg[u]++;
	nxt[edges] = fst[u];
	eend[edges] = v;
	type[edges] = -1;
	edgeId[edges] = id;
	fst[u] = edges++;
}

vector <pii> g2[MAXV];
bool was[MAXV];

void dfs(int v)
{
	was[v] = true;
	for (int i = 0; i < (int)g[v].size(); i++)
	{
		int to = g[v][i].fi;
		int id = g[v][i].se;
		if (was[to]) continue;
		addEdge(v, to, id);
		addEdge(to, v, id);
		dfs(to);
	}
}
	
int dp[2][MAXV];

int f(int v, int taken, int par = -1)
{
	int &res = dp[taken][v];
	if (res != -1) return res;
	res = 0;
	int cnt[3] = {0};
	for (int i = fst[v]; i != -1; i = nxt[i])
	{
		int to = eend[i];
		if (to == par) continue;

		int res0 = f(to, 0, v);
		int res1 = f(to, 1, v);

		if (res0 && res1) cnt[2]++;
		else if (res1) cnt[1]++;
		else if (res0) cnt[0]++;
		else return res = 0;
	}

	int now = deg[v] - taken - cnt[1];
	for (int i = 0; i <= min(1, cnt[2]) && now - i > 0; i++)
	{
		if ((now - i) & 1)
		{
			res = 1;
			break;
		}
	}
		
	return res;
}

bool answer[MAXE];
void out(int v, int taken, int par = -1)
{
	int cnt[3] = {0};
	for (int i = fst[v]; i != -1; i = nxt[i])
	{
		int to = eend[i];
		if (to == par) continue;
			
		int res0 = f(to, 0, v);
		int res1 = f(to, 1, v);

		if (res0 && res1)
		{
			type[i] = 2;
			cnt[2]++;
		}	
		else if (res1) 
		{
			type[i] = 1;
			cnt[1]++;
		}	
		else if (res0)
		{
			type[i] = 0;
			cnt[0]++;
		}	
	}

	int now = deg[v] - taken - cnt[1];
	int more;
	for (more = 0; more <= min(1, cnt[2]) && now - more > 0; more++)
		if ((now - more) & 1) break;

	for (int i = fst[v]; i != -1; i = nxt[i])
	{
		int to = eend[i];
		int id = edgeId[i];
		if (to == par) continue;

		if (type[i] == 2)
		{
			type[i] = (more > 0 ? 1 : 0);
			if (more > 0) more--;
		}

		answer[id] = (type[i] == 0);
		out(to, type[i], v);
	}	
}

void solve()
{
	memset(dp, -1, sizeof(dp));
	memset(fst, -1, sizeof(fst));
	for (int i = 0; i < n; i++)
	{
		if (was[i]) continue;
		dfs(i);
		if (!f(i, 0))
		{
			printf("-1\n");
			return;
		}
		out(i, 0);
	}	
	int cnt = 0;
	for (int i = 0; i < m; i++)
		cnt += answer[i];
	printf("%d\n", cnt);
	for (int i = 0, first = 1; i < m; i++)
	{
		if (!answer[i]) continue;
		if (!first) printf(" ");
		printf("%d", i + 1);
		first = 0;
	}
	printf("\n");
}

int main()
{
	freopen(TASK".in", "r", stdin);
	freopen(TASK".out", "w", stdout);
	clock_t start = clock();
	load();
	eprintf("reading = %.6lf\n", (double)(clock() - start) / CLOCKS_PER_SEC);
	clock_t start2 = clock();
	solve();
	eprintf("solution = %.6lf\n", (double)(clock() - start2) / CLOCKS_PER_SEC);
	eprintf("all = %.6lf\n", (double)(clock() - start) / CLOCKS_PER_SEC);
	return 0;
}
