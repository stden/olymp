#include <iostream>
#include <cassert>
#include <cmath>
#include <string>
#include <cstring>
#include <vector>
#include <fstream>
#include <algorithm>
#include <cstdio>
#include <cstdlib>
#include <set>
#include <map>
#include <iomanip>
#define nextLine() { for (int c = getchar(); c != '\n' && c != EOF; c = getchar()); }
#define sqr(a) ((a)*(a))
#define has(mask,i) (((mask) & (1<<(i))) == 0 ? false : true)
#define eprintf(...) fprintf(stderr, __VA_ARGS__)
#define TASK "loudcats"
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

int n, m, a;
int b[201];
void load()
{
	scanf("%d%d%d", &n, &m, &a);
	for (int i = 0; i < n * m; i++)
		scanf("%d", &b[i]);
}

void solve()
{
	int res = 0;
	for (int i = m; i < n * m; i++)
		res += a * (b[i] > 2 * b[i - m] ? 1 : 0);
	cout << res << endl;
}

int main()
{
	freopen(TASK".in", "r", stdin);
	freopen(TASK".out", "w", stdout);
	load();
	solve();
	return 0;
}
