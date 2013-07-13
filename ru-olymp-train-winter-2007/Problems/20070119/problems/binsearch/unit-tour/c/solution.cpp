#include "binsearch.h"

int main() {
	int n = getN();
	int x = 0;
	x += query(1);
	x += query(1);
	x += query(1);
	answer(3 - x);
	return 0;
}
