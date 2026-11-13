#include "binsearch.h"

bool detected;

int process(int x) {
	if (detected) return query(x);
	int a = query(x);
	int b = query(x);
	if (a == b) return a;
	detected = true;
	return query(x);
}

int main() {
	int n = getN();
	int l = 0;
	int r = n + 1;
	detected = false;
	while (r - l > 1) {
		int m = (l + r) / 2;
		if (process(m)) r = m;
		else l = m;
	}
	answer(r);
	return 0;
}
