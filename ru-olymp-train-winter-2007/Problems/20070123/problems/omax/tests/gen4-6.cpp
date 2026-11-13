#include <fstream>
#include <vector>
using namespace std;

int BEGTEST = 4;
int ENDTEST = 6;
const int MINN = 50;
const int MAXN = 300;
const int MINM = 1001;
const int MAXM = 10001;

int GetRand()
{
	int a = rand() * 9999 + rand();
	if (a < 0) a = -a;
	return a;
}

int n, m;
int prm1[MAXN + 1], prm2[MAXN + 1];

void GenP1()
{
	int i;
	for (i = 1; i <= n; i++)
	{
		prm1[i] = i;
	}
	for (i = 1; i <= 10 * n; i++)
	{
		int i1 = GetRand() % n + 1;
		int i2 = GetRand() % n + 1;
		int t = prm1[i1];
		prm1[i1] = prm1[i2];
		prm1[i2] = t;
	}
}

void GenP2()
{
	int i;
	for (i = 1; i <= n; i++)
	{
		prm2[i] = i;
	}
	for (i = 1; i <= 10 * n; i++)
	{
		int i1 = GetRand() % n + 1;
		int i2 = GetRand() % n + 1;
		int t = prm2[i1];
		prm2[i1] = prm2[i2];
		prm2[i2] = t;
	}
}

int first[MAXN + 1];
int next[MAXM + 1];
vector<int> ee;
int num[MAXN + 1];

void AddEdge(int v1, int v2)
{
	ee.push_back(v2);
	next[ee.size() - 1] = first[v1];
	first[v1] = ee.size() - 1;
}

int was[110000];

void GenTest(ostream& out)
{
	memset(first, 0xFF, sizeof(first));
	memset(num, 0, sizeof(num));
	memset(was, 0, sizeof(was));
	ee.clear();
	n = GetRand() % (MAXN - MINN + 1) + MINN;
	m = GetRand() % (MAXM - MINM + 1) + MINM;
	GenP1();
	GenP2();
	int i;
	int cl = 2, cr = 2;
	int left = m - n;
	if (left < 0) left = 0;
	for (i = 1; i <= n; i++)
	{
		AddEdge(prm1[i], prm2[i]);
		if (i == 1) continue;
		int cadd = GetRand() % 2;
		int numadd;
		if (left == 0) numadd = 0;
		else numadd = GetRand() % left;
		int radd = 0;
		int j;
		if (cadd == 0)
		{
			for (j = 0; j < numadd; j++)
			{
				int cur = GetRand() % (i - 1) + 1;
				if (was[cur] != i)
				{
					was[cur] = i;
					AddEdge(prm1[cur], prm2[i]);
					radd++;
				}
			}
		}
		else
		{
			for (j = 0; j < numadd; j++)
			{
				int cur = GetRand() % (i - 1) + 1;
				if (was[cur] != i)
				{
					was[cur] = i;
					AddEdge(prm1[i], prm2[cur]);
					radd++;
				}
			}
		}
		left -= radd;
		if (left < 0) left = 0;
	}
	out << n << "\n";
	memset(num, 0, sizeof(num));
	for (i = 1; i <= n; i++)
	{
		int j;
		for (j = first[i]; j != -1; j = next[j])
		{
			num[i]++;
		}
		out << num[i];
		for (j = first[i]; j != -1; j = next[j])
		{
			out << " " << ee[j];
		}
		out << "\n";
	}
}

int main()
{
	srand(25789);
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