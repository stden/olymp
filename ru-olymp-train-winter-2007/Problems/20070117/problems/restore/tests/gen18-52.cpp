#include <fstream>
#include <cstdlib>
#include <ctime>
using namespace std;

const int MAXLEN = 50;
const int MAXN = 30;
const int MAXPATH = 5;
const int TRYADD = 16890;
int MAXCOUNT = 1000000000;
int BEGTEST = 18;
int ENDTEST = 52;

int GetRand()
{
	int a = rand() * 1000 + rand();
	if (a < 0) a = -a;
	return a;
}

int ma[MAXN + 1][MAXN + 1];
int prm[MAXN + 1];
int n;

void GenP()
{
	int i;
	for (i = 1; i <= n; i++)
	{
		prm[i] = i;
	}
	for (i = 1; i <= n; i++)
	{
		int i1 = rand() % n + 1, j1 = rand() % n + 1;
		int t = prm[i1];
		prm[i1] = prm[j1];
		prm[j1] = t;
	}
}

int dist[MAXN + 1];
int q[MAXN + 1];

void CountDist()
{
	memset(dist, 0x7F, sizeof(dist));
	dist[1] = 0;
	int hd, tl;
	hd = tl = 0;
	q[hd] = 1;
	while (hd <= tl)
	{
		int i;
		for (i = 1; i <= n; i++)
		{
			if (ma[q[hd]][i] == 1)
			{
				if (dist[i] > dist[q[hd]] + 1)
				{
					tl++;
					dist[i] = dist[q[hd]] + 1;
					q[tl] = i;
				}
			}
		}
		hd++;
	}
	#ifdef FTC_DEBUG
	int i;
	out << "Distances:\n";
	for (i = 1; i <= n; i++) out << dist[i] << " ";
	out << "\n";
	#endif
}

int edg[11000][2];

void GenTest(ofstream& out)
{
	n = rand() % (MAXN - 9) + 10;
	memset(ma, 0, sizeof(ma));
	int numpth = rand() % (MAXPATH - 1) + 2;
	GenP();
	int cur = 2;
	while (cur <= n)
	{
		int prv = 1;
		int num = (n - 1) / numpth;
		while ((cur <= n) && (num != 0))
		{
			ma[prv][cur] = ma[cur][prv] = 1;
			prv = cur;
			cur++;
			num--;
		}
	}
	CountDist();
	int i, mplen = 0;
	for (i = 1; i <= n; i++)
	{
		if (dist[i] > mplen) mplen = dist[i];
	}
	for (i = 1; i <= TRYADD; i++)
	{
		int i1, j1;
		i1 = rand() % n + 1;
		j1 = rand() % n + 1;
		if (abs(dist[i1] - dist[j1]) <= 1)
		{
			ma[i1][j1] = ma[j1][i1] = 1;
		}
	}
	int m = 0;
	int j;
	for (i = 1; i <= n; i++)
	{
		for (j = i + 1; j <= n; j++)
		{
			if (ma[i][j] == 1) m++;
		}
	}
	out << n << " " << m << " " << GetRand() % 1000000000 + 1000000 << "\n";
	int ced = 0;
	for (i = 1; i <= n; i++)
	{
		for (j = i + 1; j <= n; j++)
		{
			if (ma[i][j] == 1)
			{
				ced++;
				edg[ced][0] = prm[i];
				edg[ced][1] = prm[j];
			}
		}
	}
	for (i = 1; i <= m; i++)
	{
		int i1 = rand() % m + 1;
		int i2 = rand() % m + 1;
		int u;
		for (u = 0; u <= 1; u++)
		{
			int t = edg[i1][u];
			edg[i1][u] = edg[i2][u];
			edg[i2][u] = t;
		}
	}	
	for (i = 1; i <= m; i++)
	{
		out << edg[i][0] << " " << edg[i][1] << "\n";
	}

	out << prm[1] << "\n";
	int ns = MAXLEN;
	out << ns << "\n";
	int wd = 1;
	for (i = 1; i <= ns; i++)
	{
		if (wd == 1) wd = 2;
		else if (wd == mplen) wd--;
		else
		{
			if (rand() % 2 == 0) wd++;
			else wd--;
		}
		out << wd << " " << GetRand() % MAXCOUNT + 1 << "\n";
	}
}

int main()
{
	srand(2965);
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