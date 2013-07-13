#include <fstream>
using namespace std;

ifstream in("game.in");
ofstream out("game.out");


const int MAXN = 15;

int n;
int choose[MAXN][MAXN];
double p[MAXN][MAXN];

void Load()
{
	in >> n;
	int i, j;
	for (i = 0; i < n; i++)
	{
		for (j = 0; j < n; j++)
		{
			in >> choose[i][j];
		}
	}
	for (i = 0; i < n; i++)
	{
		for (j = 0; j < n; j++)
		{
			in >> p[i][j];
		}
	}
}

double res[MAXN][1 << MAXN];
int gn[MAXN];
int gp[MAXN];

void Solve()
{
	int i;
	for (i = 0; i < n; i++) 
	{
		gn[i] = (i + 1) % n;
		gp[i] = (i + n - 1) % n;
	}
	int msk, pos;
	for (msk = (1 << n) - 1; msk >= 0; msk--)
	{
		char numnc = 0, bi = 0;
		for (i = 0; i < n; i++)
		{
			if ( (msk & (1 << i)) == 0)
			{	
				numnc++;
				bi = i;
			}
		}		
		int fff = 0;
		for (pos = bi; ; pos = gp[pos])
		{
			if (fff == 0) fff = 1;
			else
			{
				if (pos == bi) break;
			}
		    if (numnc == 1)
			{
				res[pos][msk] = 0;
				continue;
			}
			if ( (msk & (1 << pos)) != 0)
			{
				res[pos][msk] = res[gn[pos]][msk];
				continue;
			}
			double nkill = 1;
			int j;
    	
			double tp = 0;
	    	double tres = 0;
			int sum = 0;
			for (i = 0; i < n; i++)
			{
				if ( (msk & (1 << i)) != 0) continue;
				if (i == pos) continue;
				tres += (res[gn[pos]][msk | (1 << i)] * choose[pos][i] * p[pos][i]);
				sum += choose[pos][i];
				tp += choose[pos][i] * p[pos][i];
			}
			tres = tres / sum;
			tp /= sum;
			tp = 1 - tp;
			tres += 1;
    	
			for (i = gn[pos]; i != pos; i = gn[i])
	    	{
				if ( (msk & (1 << i)) != 0) continue;
				double ttres = 0;           
				double ttp = 0;
				sum = 0;
				for (j = 0; j < n; j++)
				{
					if ( (msk & (1 << j)) != 0) continue;
					if (j == i) continue;
					ttres += (res[gn[i]][msk | (1 << j)] * choose[i][j] * p[i][j] );
					sum += choose[i][j];
					ttp += choose[i][j] * p[i][j];
				}
				ttres /= sum;
				ttp /= sum;
				ttp = 1 - ttp;
				tres += tp * (1 + ttres);
    	
				tp *= ttp;
	    	}
    	
			nkill = tp;
        
			res[pos][msk] = tres / (1 - nkill);		
		}
	}

	out.setf(ios::fixed | ios::showpoint);
	out.precision(5);
	out << res[0][0];
}

int main()
{
	Load();
	Solve();
	return 0;
}        