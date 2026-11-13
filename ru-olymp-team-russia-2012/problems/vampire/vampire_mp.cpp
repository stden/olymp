#include <cstdio>
#include <string>
#include <algorithm>
using namespace std;
#define sz(a) ((int) (a).size())

struct trash {
	string mult1, mult2, prod;
	void output() {
		printf("%s=%sx%s\n", prod.data(), mult1.data(), mult2.data());
	}
};

bool equals(string s, string t) {
	sort(s.begin(), s.end());
	sort(t.begin(), t.end());
	return s == t;
}

string str(int n) {
	char tmp[10];
	sprintf(tmp, "%d", n);
	return tmp;
}

const int N = (int) 1e6;
int k, n, total;
trash numbers[N];
bool used[N];

void generate(int l) {
	trash t;
	for (int i = 1; (sz(str(i)) <= l) && (total <= k); ++i)
		for (int j = i; (sz(str(j)) <= l) && (total <= k); ++j) {
			if (((i % 10 == 0) && (j % 10 == 0)) || used[i * j])
				continue;
			t.mult1 = str(i);
			t.mult2 = str(j);
			t.prod  = str(i * j);
			if ((sz(t.mult1) == sz(t.mult2)) && (sz(t.prod) == 2 * sz(t.mult1)) && equals(t.mult1 + t.mult2, t.prod)) {
				used[i * j] = true;
				numbers[total++] = t;
			}
		}	
}

int main() {
	freopen("vampire.in", "r", stdin);
	freopen("vampire.out", "w", stdout);
	scanf("%d%d", &k, &n);
	generate(min(3, n / 2));
	for (int i = 0; i < k; ++i) {
		while (sz(numbers[i].prod) < n) {
			numbers[i].mult1 += "0";
			numbers[i].mult2 += "0";
			numbers[i].prod += "00";
		}
		numbers[i].output();
	}
	
}