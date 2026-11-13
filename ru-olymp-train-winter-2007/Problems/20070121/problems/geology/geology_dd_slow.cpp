#include <cstdio>
using namespace std;

#define int64 __int64

int64 sum[110000];

void Solve()
{
	int n;
	scanf("%d", &n);
	int i;
	for (i = 0; i < n; i++)
	{
		char c = getchar();
		while ((c < 'A') || (c > 'Z')) c = getchar();
		if (c == 'A')
		{
			c = getchar();
			c = getchar();
			int x, p;
			scanf("%d%d", &x, &p);
			int j;
			int cur = 2 * p - 1;
			for (j = x - 1; cur > 0; j--)
			{
				if (j < 1) break;
				sum[j] += cur;
				cur -= 2;
			}
			cur = 2 * p - 1;
			for (j = x; cur > 0; j++)
			{
				if (j > 10000) break;
				sum[j] += cur;
				cur -= 2;
			}
		}
		else
		{
			c = getchar();
			c = getchar();
			c = getchar();
			c = getchar();
			int x1, x2;
			scanf("%d%d", &x1, &x2);
			if (x1 == x2)
			{
				printf("0.000\n");
			}
			else
			{
				if (x1 > x2)
				{
					int t = x1;
					x1 = x2;
					x2 = t;
				}
				int64 res = 0;
				int j;
				for (j = x1; j < x2; j++)
				{
					res += sum[j];
				}
				double r = res;
				r /= 2;
				printf("%.3lf\n", r);
			}
		}
	}
}

int main()
{
	freopen("geology.in", "rt", stdin);
	freopen("geology.out", "wt", stdout);
	Solve();
	return 0;
}