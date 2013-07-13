#include <fstream>
using namespace std;

ifstream in("restore.in");
ofstream out("restore.out");

#define int64 __int64
#define FTC_DEBUG
#undef FTC_DEBUG

const int MAXN = 30;
const int MAXLEN = 50;

int n, m, p;
char ma[MAXN + 1][MAXN + 1];
int begver, nseq;
int seq[MAXLEN + 1], cnt[MAXLEN + 1];
int64 numpt;

void Load()
{
	memset(ma, 0, sizeof(ma));
	in >> n >> m >> p;
	int p, q, i;
	for (i = 1; i <= m; i++)
	{
		in >> p >> q;
		ma[p][q] = ma[q][p] = 1;
	}	
	in >> begver;
	in >> nseq;
	for (i = 1; i <= nseq; i++)
	{
		in >> seq[i] >> cnt[i];
	}
	in >> numpt;
}

int dist[MAXN + 1];
int q[MAXN + 1];

void CountDist()
{
	memset(dist, 0x7F, sizeof(dist));
	dist[begver] = 0;
	int hd, tl;
	hd = tl = 0;
	q[hd] = begver;
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

int64 res[2][MAXN + 1];

void Solve()
{
	CountDist();
	memset(res, 0, sizeof(res));
	int i;
	for (i = 1; i <= n; i++)
	{
		if (dist[i] == seq[1])
		{
			res[0][i] = 1;
		}
	}	 
	cnt[1]--;
	int cr = 0;
	int j;
	int k, l;
	for (i = 1; i <= nseq; i++)
	{
		for (j = 1; j <= cnt[i]; j++)
		{
			memset(res[1 - cr], 0, sizeof(res[1 - cr]));
			for (k = 1; k <= n; k++)
			{
				if (res[cr][k] != 0)
				{
					for (l = 1; l <= n; l++)
					{
						if ((dist[l] == seq[i]) && (ma[k][l] == 1))
						{
							res[1 - cr][l] += res[cr][k];
							if (res[1 - cr][l] >= p) res[1 - cr][l] -= p;
						}
					}
				}
			}
			cr = 1 - cr;                                                                           
		}
	}
	int64 sum = 0;
	for (i = 1; i <= n; i++)
	{
		sum += res[cr][i];
		if (sum >= p) sum -= p;
	}
	out << sum;
}                                                                                                       

int main()
{
    Load();
    Solve();
	return 0;
}