#include <cassert>
#include <cstdio>
#include <vector>
using namespace std;

const int N = (int) 1e5;
const int inf = (int) 1e9 + 1;
int n, t, a[N + 2];
long long cnt[N + 1], res, m, tmp;
vector<int> cur;

int main() {
	assert(freopen("exam.in", "r", stdin));
	assert(freopen("exam.out", "w", stdout));
	scanf("%d", &t);
	while (t--) {
		scanf("%d", &n);
		a[0] = m = res = 0;
		for (int i = 1; i <= n; ++i) {
			scanf("%d", &a[i]);
			m += max(a[i - 1] - a[i], 0);
			cnt[i] = 0;
		}
		a[0] = a[n + 1] = inf;
		cur.clear();
		for (int i = 0; i <= n + 1; ++i) {
			while (!cur.empty() && (a[cur.back()] < a[i])) {
				tmp = a[cur.back()];
				cur.pop_back();
				cnt[i - cur.back() - 1] += min(a[i], a[cur.back()]) - tmp;
			}
			cur.push_back(i);
		}
		m = max(0LL, m - a[1]);
		for (int i = 1; i <= n; ++i) {
			tmp = min(m, cnt[i]);
			res += i * tmp;
			m -= tmp;
		}
		printf("%I64d\n", res);
	}
	return 0;
}