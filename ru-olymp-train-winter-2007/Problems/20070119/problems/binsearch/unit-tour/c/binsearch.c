#include <stdio.h>
#include <stdlib.h>

static int n;


int getN() {
	do {
		printf("enter n: ");
		scanf("%d", &n);
		if (n < 1 || n > 60) {
			printf("invalid n, n must be between 1 and 60\n");
		}
	} while (n < 1 || n > 60);
	return n;
}

int query(int i) {
	int t;

	if (i < 1 || i > n) {
		printf("invalid query: %d\n", i);
		exit(1);
	}

	do {
		printf("is y <= x[%d] (1 - yes, 0 - no)?\n", i);
		scanf("%d", &t);
		if (t != 0 && t != 1) {
			printf("enter 1 or 0\n");
		}
	} while (t != 0 && t != 1);
	return t;
}

void answer(int i) {
	printf("program answers %d\n", i);
}
