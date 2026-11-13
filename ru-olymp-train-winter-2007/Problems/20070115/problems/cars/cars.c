#include <stdio.h>

#define MAXCARS 10
#define LINES 12
#define CONFS (5*5*5*5*5*5*5*5*5*5)
#define QSIZE (CONFS/8)
#define INFILE "cars.in"
#define OUTFILE "cars.out"

struct car {
	int line;	/* In which line car is (0-5 rows, 6-11 columns */
	int len;	/* Length of the car */
};

int cars;
struct car config[MAXCARS];
unsigned char p[CONFS];

int read_cars(void)
{
	int pos = 0, i;
	int line, off, mult;
	char rc, ct;
	FILE *f;

	if (!(f = fopen(INFILE, "r"))) {
		printf("Cannot open input file!\n");
		exit(1);
	}
	fscanf(f, "%d\n", &cars);
	for (i = 0, mult = 1; i < cars; i++, mult *= 5) {
		fscanf(f, "%c %d %d %c\n", &rc, &line, &off, &ct);
		line--; off--;
		if (rc == 'v') {
			int tmp = line;
			line = off+6;
			off = tmp;
		}
		config[i].line = line;
		config[i].len = (ct == 'c') ? 2 : 3;
		pos += off*mult;
	}
	fclose(f);
	return pos;
}

void extract_offs(int pos, int *offs)
{
	int i;

	for (i = 0; i < MAXCARS; i++) {
		offs[i] = pos % 5;
		pos /= 5;
	}
}

int recode(int *offs, int n, int a)
{
	int pos = 0, i;

	for (i = cars-1; i>= 0; i--) {
		pos = pos*5 + offs[i];
		if (i == n)
			pos += a;
	}
	return pos;
}

int collides(int line, int *offs, int entry)
{
	int i;

	for (i = 0; i < cars; i++) {
		if (config[i].line == line && offs[i] <= entry%6 && offs[i]+config[i].len-1 >= entry%6)
			return 1;
		if (config[i].line == entry && offs[i] <= line%6 && offs[i]+config[i].len-1 >= line%6)
			return 1;
	}
	return 0;
}

int search(int pos)
{
	int queue[QSIZE];
	int qstart = 0, qend = 0;
	int i, j, npos;
	int offs[MAXCARS];

	p[pos] = 1;
	queue[qstart++] = pos;
	while (qstart != qend) {
		pos = queue[qend++];
		if (qend >= QSIZE)
			qend = 0;
		extract_offs(pos, offs);
		for (i = 0; i < cars; i++) {
			for (j = 1; offs[i]+j+config[i].len <= 6; j++) {
				/* No car in the column or it doesn't block us? */
		        	if (!collides(offs[i]+config[i].len-1+j+(config[i].line >= 6?0:6), offs, config[i].line)) {
					npos = recode(offs, i, j);
					if (!p[npos]) {
						queue[qstart++] = npos;
						if (qstart >= QSIZE)
							qstart = 0;
						p[npos] = p[pos]+1;
						/* Finished? */
						if (i == 0 && offs[i]+config[i].len+j == 6)
							return p[npos]-1;
					}
				}
				else
					break;
			}
			for (j = -1; offs[i]+j >= 0; j--) {
				/* No car in the column or it doesn't block us? */
		        	if (!collides(offs[i]+j+(config[i].line>=6?0:6),offs, config[i].line)) {
					npos = recode(offs, i, j);
					if (!p[npos]) {
						queue[qstart++] = npos;
						if (qstart >= QSIZE)
							qstart = 0;
						p[npos] = p[pos]+1;
					}
				}
				else
					break;
			}
		}
	}
	return -1;
}

int main(void)
{
	int ret;
	FILE *out;
	
	ret = search(read_cars());
	out = fopen(OUTFILE, "w");
	if (ret == -1)
		fprintf(out, "The car is trapped.\n");
	else
		fprintf(out, "%d\n", ret);
	fclose(out);
	return 0;
}
