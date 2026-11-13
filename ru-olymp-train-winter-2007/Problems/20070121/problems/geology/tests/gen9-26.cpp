#include <fstream>
#include <cstdlib>
#include <ctime>
using namespace std;

const int BEGTEST = 9;
const int ENDTEST = 26;

const int MAXMAXX = 100000;
const int MINMAXX = 50000;
const int MAXP = 1000000;
const int MAXN = 100000;      
const int MINN = 50000;

int GetRand()
{
	int a = rand() * 9999 + rand();
	if (a < 0) a = -a;
	return a;
}

void GenTest(ostream &out)
{
	int mx = GetRand() % (MAXMAXX - MINMAXX + 1) + MINMAXX;
	int n = GetRand() % (MAXN - MINN + 1) + MAXN;
	int i;
	out << n << "\n";
	for (i = 1; i <= n; i++)
	{
		int op = GetRand() % 2;
		if (op == 0)
		{
			int x = GetRand() % mx + 1;
			int p = GetRand() % MAXP + 1;
			out << "ADD " << x << " " << p << "\n";
		}
		else
		{
			int x1 = GetRand() % mx + 1;
			int x2 = GetRand() % mx + 1;
			out << "QUERY " << x1 << " " << x2 << "\n";
		}
	}
}

int main()
{           
	unsigned seed = 7688;
	srand(seed);
	int i;
	for (i = BEGTEST; i <= ENDTEST; i++)
	{
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