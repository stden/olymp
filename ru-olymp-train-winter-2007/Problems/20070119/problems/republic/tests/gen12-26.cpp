#include <fstream>
#include <cstdlib>
#include <ctime>
using namespace std;

const int BEGTEST = 12;
const int ENDTEST = 26;

const int seeds [15] =
{
1169150934,
1169150949,
1169150996,
1169151041,
1169151067,
1169151085,
1169151130,
1169151139,
1169151160,
1169151178,
1169151245,
1169151252,
1169151337,
1169151395,
1169151496
};


const int MINN = 50000;
const int MAXN = 100000;
const int MAXM = 100000;

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