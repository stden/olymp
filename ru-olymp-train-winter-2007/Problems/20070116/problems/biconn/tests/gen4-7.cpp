#include <fstream>
#include <cstdlib>
#include <ctime>
using namespace std;

#pragma comment (linker, "/STACK:20000000")

const int MINN = 100;
const int MAXN = 1000;
const int BEGTEST = 4;
const int ENDTEST = 7;

inline void Swap(int &a, int &b)
{
	int t = a;
	a = b;
	b = t;
}

int rt[MAXN + 1];
int edg[MAXN + 1][2];

void GenTest(ofstream& out)
{
	int n = rand() % (MAXN - MINN) + MINN;
    out << n << "\n";
    int i;
    int l = rand() % n + 1;
    while ((3 * l > n) || (4 * l < n))
    {
    	l = rand() % n + 1;
    }
	int last = n - 2 * l;
	int cur = n;
	for (i = 1; i <= l; i++)
	{
		rt[cur] = last;
		cur--;
		rt[cur] = last;
		cur--;
		last--;
	}
	for (i = 2; i <= cur; i++)
	{
		rt[i] = rand() % (i - 1) + 1;
	}
	for (i = 2; i <= n; i++)
	{
		edg[i][0] = i;
		edg[i][1] = rt[i];
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
	srand(6778);
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