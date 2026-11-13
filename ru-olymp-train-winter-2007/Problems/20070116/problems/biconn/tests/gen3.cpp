#include <fstream>
#include <cstdlib>
#include <ctime>
using namespace std;

const int MINN = 40000;
const int MAXN = 50000;
const int BEGTEST = 3;
const int ENDTEST = 3;

inline void Swap(int &a, int &b)
{
	int t = a;
	a = b;
	b = t;
}

int edg[MAXN + 1][2];


void GenTest(ofstream& out)
{
	int n = rand() % (MAXN - MINN) + MINN;
    out << n << "\n";
	int i;
	for (i = 2; i <= n; i++)
	{
		int t = i - 1;
		edg[i][0] = t;
		edg[i][1] = i;
	}
	for (i = 1; i <= n; i++)
	{
		int i1 = rand() % (n - 1) + 2;
		int i2 = rand() % (n - 1) + 2;
		Swap(edg[i1][0], edg[i2][0]);
		Swap(edg[i1][1], edg[i2][1]);
	}
	for (i = 2; i <= n; i++)
	{
		out << edg[i][0] << " " << edg[i][1] << "\n";
	}
}

int main()
{
	srand(2896);
	ofstream out("biconn.in");
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