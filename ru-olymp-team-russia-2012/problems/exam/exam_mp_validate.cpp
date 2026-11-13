#include <cassert>
#include <cstdio>

const int N = (int) 1e5;
const int INF = (int) 1e9;

int main() {
	int n, x, t, sum = 0;
	assert(freopen("exam.in", "r", stdin));
	assert(freopen("exam.out", "w", stdout));
	assert(scanf("%d", &t) == 1);
	while (t--) {
		assert(scanf("%d", &n) == 1);
		assert((1 <= n) && (n <= N));
		sum += n;
		for (int i = 0; i < n; ++i) {
			assert(scanf("%d", &x) == 1);
			assert((0 <= x) && (x <= INF));
		}
	}
	assert(sum <= N);
	return 0;
}