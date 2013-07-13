#include <fstream>
#include <cstdlib>
#include <ctime>
using namespace std;

const int BEGTEST = 2;
const int ENDTEST = 11;

const int seeds [10] =
{
1169147920,
1169147926,
1169147927,
1169147933,
1169147934,
1169147938,
1169147941,
1169147957,
1169147960,
1169147963
};

const int MINN = 100;
const int MAXN = 1000;
const int MAXM = 10000;

int GetRand()
{
	int a = rand() * 32768 + rand();
	if (a < 0) a = -a;
	return a;
}

void GenTest(ostream& out)
{
	int n, m;
	n = GetRand() % (MAXN - MINN + 1) + MINN;
	m = GetRand() % MAXN + 1;
	out << n << " " << m << "\n";
	int i;
	for (i = 0; i < m; i++)
	{
		int p, q;
		p = GetRand() % n + 1;
		q = GetRand() % n + 1;
		out << p << " " << q << "\n";
	}
}


int main()
{
    unsigned seed = (unsigned)time(NULL);
	srand(seed);
	int i;
	for (i = BEGTEST; i <= ENDTEST; i++)
	{
		srand(seeds[i - BEGTEST]);
		char num[100];
		char name[100];
		itoa(i, num, 10);
		if (strlen(num) < 2)
		{
			strcpy(name, "0");
		}
		else strcpy(name, "");
		strcat(name, num);
		ofstream out(name);
		GenTest(out);
		out.close();
	}
	return 0;
}