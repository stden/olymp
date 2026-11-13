#include <fstream>
using namespace std;

ifstream in("restore.in");
ofstream out("restore.out");

#define int64 __int64
#define FTC_DEBUG
#undef FTC_DEBUG

const int MAXN = 30;
const int MAXLEN = 100;

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

class Matr
{
public:
	int64 a[MAXN + 1][MAXN + 1];
};

Matr tmp;

inline void Swap(int64 &a, int64 &b)
{
	int64 t = a;
	a = b;
	b = t;
}

void operator*=(Matr &b, Matr &a)
{
	memset(tmp.a, 0, sizeof(tmp.a));
	int i, j, k;
	for (i = 1; i <= n; i++)
	{
		for (j = 1; j <= n; j++)
		{
			for (k = 1; k <= n; k++)
			{
				tmp.a[i][j] += (b.a[i][k]) * a.a[k][j];
				if (tmp.a[i][j] >= p) tmp.a[i][j] %= p;
			}
		}
	}
	memcpy(b.a, tmp.a, sizeof(tmp.a));
}

void PowMa(Matr &a, Matr &b, int pw)
{
	if (pw == 0)
	{
		memset(b.a, 0, sizeof(b.a));
		int i;
		for (i = 1; i <= n; i++)
		{
			b.a[i][i] = 1;
		}
		return;
	}
	if (pw == 1)
	{
		memcpy(b.a, a.a, sizeof(b.a));
		return;
	}
	PowMa(a, b, pw / 2);
	b *= b;
	if (pw % 2 == 1)
	{
		b *= a;
	}
}

int64 res[MAXN + 1];
Matr rma, b, c;

ostream& operator<<(ostream& out, Matr &a)
{
	int i, j;
	for (i = 1; i <= n; i++)
	{
		for (j = 1; j <= n; j++)
		{
			out << a.a[i][j] << " ";
		}
		out << "\n";
	}
	return out;
}

void Solve()
{
	CountDist();
	memset(res, 0, sizeof(res));
	int i;
	for (i = 1; i <= n; i++)
	{
		if (dist[i] == seq[1])
		{
			res[i] = 1;
		}
	}	 
	cnt[1]--;
	int cr = 0;
	memset(rma.a, 0, sizeof(rma.a));
	for (i = 1; i <= n; i++)
	{
		rma.a[i][i] = 1;
	}
	int j, k;
	for (i = 1; i <= nseq; i++)
	{
		for (j = 1; j <= n; j++)
		{
			for (k = 1; k <= n; k++)
			{
				if (dist[k] != seq[i]) b.a[j][k] = 0;
				else b.a[j][k] = ma[j][k];
			}
		}
		PowMa(b, c, cnt[i]);
		rma *= c;
		#ifdef FTC_DEBUG
		out << "Multiplied by:\n" << c << "\nGot new matrix\n" << rma << "\n";
		#endif
	}
	int64 sum = 0;
	for (i = 1; i <= n; i++)
	{
		#ifdef FTC_DEBUG
		out << res[i] << "\n";
		#endif
		for (j = 1; j <= n; j++)
		{
			sum += res[i] * rma.a[i][j];
			sum %= p;
		}
	}
	out << sum;
}                                                                                                       

int main()
{
    Load();
    Solve();
	return 0;
}