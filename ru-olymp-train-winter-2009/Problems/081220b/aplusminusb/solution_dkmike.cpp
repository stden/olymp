#include <stdio.h>
#include <string.h>
#include <malloc.h>

#define max(a, b) ((a > b) ? a : b)
#define min(a, b) ((a < b) ? a : b)

#define DIG  (5)
#define OSN  (100000)
#define MAXN (25100)
#define LEN  (100010)

typedef struct tag_long_t {
	int num[MAXN];
	int size;

	tag_long_t() {
		size = 0;
		memset(num, 0, sizeof(num));
	}
} long_t;

void readLong(long_t &a) {
	char str[LEN] = {0};
	gets(str);
	int j = 0;
	int pow = 1;
	int N = strlen(str);
	for (int i = N - 1; i >= 0; i--) {
		if (DIG == j) {
			j = 0;
			a.size++;
			pow = 1;
		}
		a.num[a.size] = a.num[a.size] + pow * (str[i] - '0');
		pow *= 10;
		j++;
	}
	if (j) a.size++;
}

void printZeroes(int a) {
	int len = 0;
	int aa = a;
	while (a > 0) {
		a /= 10;
		len++;
	}
	if (0 == aa)
		len = 1;
	for (int i = 0; i < DIG - len; i++)
		printf("0");
}

void printLong(const long_t &a) {
	if (0 == a.size)
		return;
	printf("%d", a.num[a.size - 1]);
	for (int i = a.size - 2; i >= 0; i--) {
		printZeroes(a.num[i]);
		printf("%d", a.num[i]);
	}
	puts("");
}

// a >= b
long_t sub(const long_t &a, const long_t &b) {
	long_t c;

	c.size = a.size;
	int p = 0;
	for (int i = 0; i < c.size; i++) {
		int cur = a.num[i] - b.num[i] + OSN - p;
		p =  1 - cur / OSN;
		c.num[i] = cur % OSN;
	}
	while (c.size > 1 && !c.num[c.size - 1]) c.size--;

	return c;
}

int main() {
	long_t a;
	long_t b;

	freopen("sub.in", "rt", stdin);
	freopen("sub.out", "wt", stdout);

	readLong(a);
	readLong(b);

	printLong(sub(a, b));

	return 0;
}
