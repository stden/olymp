#include <stdio.h>
#include <stdlib.h>

static int c;
static int was = 0;
static FILE* fout;

int getN() {
	if (was) {
		fout = fopen("31415926.out", "wt");
		fprintf(fout, "-1\ngetN called twice");
		fclose(fout);
		exit(0);
	}

	c = 0;
	was = 1;
	return 1;
}

int query(int i) {
	if (i != 1) {
		fout = fopen("31415926.out", "wt");
		fprintf(fout, "-1\ninvalid query");
		fclose(fout);
		exit(0);
	}
	c++;
	if (c == 2) {
		return 1;
	} else {
		return 0;
	}
}

void answer(int i) {
	fout = fopen("31415926.out", "wt");
	if (i != 2) {
		fprintf(fout, "-1\ninvalid answer");
	} else {
		fprintf(fout, "%d\n", c);
	}
	fclose(fout);
	exit(0);
}
