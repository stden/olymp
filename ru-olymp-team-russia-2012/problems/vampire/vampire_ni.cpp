#include <iostream>
#include <cassert>
#include <cmath>
#include <string>
#include <cstring>
#include <vector>
#include <fstream>
#include <algorithm>
#include <cstdio>
#include <cstdlib>
#include <set>
#include <map>
#include <iomanip>
#define nextLine() { for (int c = getchar(); c != '\n' && c != EOF; c = getchar()); }
#define sqr(a) ((a)*(a))
#define has(mask,i) (((mask) & (1<<(i))) == 0 ? false : true)
#define eprintf(...) fprintf(stderr, __VA_ARGS__)
#define TASK "vampire"
using namespace std;

#define pii pair<int,int>
#define mp make_pair
#define pb push_back
#define fi first
#define se second

#if ( _WIN32 || __WIN32__ )
    #define LLD "%I64d"
#else
    #define LLD "%lld"
#endif

typedef long long LL;
typedef long double ldb;
typedef vector <int> vi;
typedef vector <vi> vvi;
typedef vector <bool> vb;
typedef vector <vb> vvb;

const int INF = (1 << 30) - 1;
const ldb EPS = 1e-9;
const ldb PI = fabs(atan2(0.0, -1.0));
const int MAXFANG = 1000;

string toString(int a)
{
	char buf[10] = {0};
	sprintf(buf, "%d", a);
	return buf;
}

void add(const string &s, vi &cnt, int d)
{
	for (int i = 0; i < (int)s.size(); i++)
		cnt[s[i] - '0'] += d;
}

bool isVampire(const string &vampire, const string &fang1, const string &fang2, int n)
{
	if (vampire.size() % 2 != 0) return false;
	if ((int)vampire.size() > n) return false;
	if (fang1.size() != vampire.size() / 2) return false;
	if (fang2.size() != vampire.size() / 2) return false;
	vi cnt(10, 0);
	add(vampire, cnt, 1);
	add(fang1, cnt, -1);
	add(fang2, cnt, -1);
	for (int i = 0; i < 10; i++)
		if (cnt[i] != 0) return false;
	return true;
}

class VampireNumber
{
public:
	int vampire;
	int fang1;
	int fang2;

	VampireNumber() {};

	VampireNumber(int fang1, int fang2)
	{
		this->fang1 = fang1;
		this->fang2 = fang2;
		fixFangs();
		vampire = this->fang1 * this->fang2;
	}

	void fixFangs()
	{
		while (fang1 % 10 == 0 && fang2 % 10 == 0)
		{
			fang1 /= 10;
			fang2 /= 10;
		}
		if (fang1 > fang2)
			swap(fang1, fang2);
	}

	void print(int n) const
	{
		string vampire = toString(this->vampire);
		string fang1 = toString(this->fang1);
		string fang2 = toString(this->fang2);
		assert((n - (int)vampire.size()) % 2 == 0);
		while ((int)vampire.size() < n)
		{
		 	vampire += "00";
		 	fang1 += "0";
		 	fang2 += "0";
		}
		printf("%s=%sx%s\n", vampire.c_str(), fang1.c_str(), fang2.c_str());
	}
};

bool operator < (const VampireNumber &a, const VampireNumber &b)
{
	return a.vampire < b.vampire;
}

void solve()
{
	int k, n;
	scanf("%d%d", &k, &n);
	set <VampireNumber> numbers;
	for (int i = 1; (int)numbers.size() < k && i <= MAXFANG; i++)
	{
		for (int j = i; (int)numbers.size() < k && j <= MAXFANG; j++)
		{
			if (isVampire(toString(i * j), toString(i), toString(j), n))
			{
				VampireNumber cur(i, j);
				numbers.insert(cur);
			}
		}
	}

	for (set <VampireNumber>::iterator it = numbers.begin(), end = numbers.end(); it != end; it++)
	{
		it->print(n);
	}
}

int main()
{
	freopen(TASK".in", "r", stdin);
	freopen(TASK".out", "w", stdout);
	solve();
	return 0;
}
