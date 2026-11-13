#include <fstream>
using namespace std;

ifstream in("system.in");
ofstream out("system.out");

const int MAXN = 200;
const int MAXC = 500;

int first[MAXN + 1], next[MAXN + 1], rt[MAXN + 1];
int crit[MAXN + 1], tort[MAXN + 1], cost[MAXN + 1];
int n;

void Load()
{
	memset(first, 0, sizeof(first));
	memset(next, 0, sizeof(next));
	in >> n;
	int i;
	for (i = 1; i <= n; i++)
	{
		in >> rt[i] >> crit[i] >> tort[i] >> cost[i];
	}	
	for (i = 1; i <= n; i++)
	{
		if (rt[i] == 0) continue;
		next[i] = first[rt[i]];
		first[rt[i]] = i;
	}
}

int res[MAXN + 1][MAXC + 1];
int res2[MAXN + 1][MAXC + 1];

int Count(int ver, int money);

int Count2(int ver, int money)
{
	if (res2[ver][money] != -1) return res2[ver][money];
	if (ver == 0)
	{
		res2[ver][money] = 0;
		return 0;
	}
	res2[ver][money] = 0;
	int i, cres;
	for (i = 0; i <= money; i++)
	{
		cres = Count(ver, money - i);
		if (cres == -2) cres = 0;
		cres += Count2(next[ver], i);
		if (cres > res2[ver][money]) res2[ver][money] = cres;
	}
	return res2[ver][money];
}

int Count(int ver, int money)
{
	if (res[ver][money] != -1) return res[ver][money];
	if (ver == 0)
	{
		res[ver][money] = 0;
		return 0;
	}
	int cres;
	res[ver][money] = -2;
	if (money >= cost[ver])
	{
		cres = Count2(first[ver], money - cost[ver]) + tort[ver];
		if (cres > res[ver][money]) res[ver][money] = cres;
	}
	cres = Count2(first[ver], money);
	if (cres >= crit[ver])
	{
		cres += crit[ver];
		if (cres > res[ver][money]) res[ver][money] = cres;
	}
	return res[ver][money];
}

void Solve()
{
	memset(res, 0xFF, sizeof(res));
	memset(res2, 0xFF, sizeof(res2));
	int i;
	for (i = 0; i <= MAXC; i++)
	{
		int rs = Count(1, i);
		if (rs != -2)
		{
			out << i << "\n";
			return;
		}
	}
	out << "Some stupid BOTVA!!!\n";
}

int main()
{
	Load();
	Solve();
	return 0;
}