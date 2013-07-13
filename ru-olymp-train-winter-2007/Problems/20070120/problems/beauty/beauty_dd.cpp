#include <fstream>
#include <set>
#include <cstdlib>
#include <algorithm>
#include <string>
#include <vector>
using namespace std;

#define FTC_DEBUG
#undef FTC_DEBUG
#define TESTCHECK_ON
#undef TESTCHECK_ON

#define int64 __int64

ifstream in("beauty.in");
ofstream out("beauty.out");

const int MAXVER = 10000;
const int MAXLEN = 100;

vector<string> ss;
int n;
int64 cost[MAXVER + 1];

int sym[MAXVER + 1];
int nver;
int go[MAXVER + 1][26];
int rt[MAXVER + 1];
int64 vercost[MAXVER + 1];

int GetGo(int ver, char c)
{
	if (go[ver][c] == 0)
	{
		nver++;
		sym[nver] = c;
		rt[nver] = ver;
		go[ver][c] = nver;
	}
	return go[ver][c];
}

void AddTree(string &a, int ccost)
{
	int i;
	int cur = 1;
	for (i = 0; i < a.length(); i++)
	{
		cur = GetGo(cur, a[i]);
	}
	vercost[cur] += ccost;
}

int suflink[MAXVER + 1];

int GetLink(int ver);

int CountGo(int ver, int sym)
{
	if (go[ver][sym] != 0) return go[ver][sym];
	if (ver == 1) go[ver][sym] = 1;
	else go[ver][sym] = CountGo(GetLink(ver), sym);
	return go[ver][sym];
}

int GetLink(int ver)
{
	if (suflink[ver] != 0) return suflink[ver];
	if (ver == 1) 
	{
		suflink[ver] = 1;
		return 1;
	}                                                       
	if (rt[ver] == 1)
	{
		suflink[ver] = 1;
		return 1;
	}
	suflink[ver] = CountGo(GetLink(rt[ver]), sym[ver]);
	return suflink[ver];
}

void WrongTest(string hh)
{
	out << "BOTVA APPEARED!!!\n";
	out << hh;
	out.close();
	exit(1);
}
                                                                                              
void Load()
{
	memset(vercost, 0, sizeof(vercost));
	nver = 1;
	int numwrd = 0;
	in >> numwrd;
	int i;
	for (i = 0; i < numwrd; i++)
	{
		string nstr = "";
		char c;
		c = in.get();
		while ((c < 'a') || (c > 'z'))
		{
			c = in.get();
		}
		while ((c >= 'a') && (c <= 'z'))
		{
			nstr += (char)(c - 'a');
			c = in.get();
		}
		ss.push_back(nstr);
		in >> cost[i];
	}
	#ifdef TESTCHECK_ON
	int alllen = 0;
	for (i = 0; i < numwrd; i++)
	{
		if (ss[i] == "") 
		{
			WrongTest("");	
		}
		alllen += ss[i].length();
		if ((cost[i] < 1) || (cost[i] > 2000000000)) WrongTest("\nWrong costs"); 
	}
	if (alllen > MAXVER) WrongTest("\nToo long words in common");
	set<string> alls;
	alls.clear();
	for (i = 0; i < numwrd; i++)
	{
		if (alls.find(ss[i]) != alls.end()) WrongTest(ss[i] + " Duplicated...");
		alls.insert(ss[i]);

	}
	#endif
	for (i = 0; i < numwrd; i++)
	{
		AddTree(ss[i], cost[i]);
	}
	memset(suflink, 0, sizeof(suflink));
	int j;	
	for (i = 1; i <= nver; i++)
	{
		GetLink(i);
		for (j = 0; j < 26; j++)
		{
			CountGo(i, j);
		}
	}
	in >> n;
	#ifdef TESTCHECK_ON
	if ((n < 1) || (n > 100))
	{
		WrongTest("\nWrong len of sequence");
	}
	#endif
	#ifdef FTC_DEBUG
	out << "Suflinks:\n";
	for (i = 1; i <= nver; i++) out << suflink[i] << " ";
	out << "\n\n";
	for (i = 1; i <= nver; i++)
	{
		for (j = 0; j < 26; j++) out << go[i][j] << " ";
		out << "\n";
	}
	#endif
}

int64 res[MAXLEN + 1][MAXVER + 1];
char rsym[MAXLEN + 1][MAXVER + 1];

int64 resval[MAXVER + 1];
int64 sumall = 0;

int64 GetResval(int ver)
{
	if (resval[ver] != -1) return resval[ver];
	if (ver == 1) 
	{
		resval[ver] = 0;
		return 0;
	}
	resval[ver] = GetResval(suflink[ver]) + vercost[ver];
	if (resval[suflink[ver]] > sumall)
	{
		out << "BOTVA on vertex " << ver << "\n";
	}
	return resval[ver];
}

void Solve()
{
	memset(resval, 0xFF, sizeof(resval));
	memset(res, 0xFF, sizeof(res));
	int i, j, k;
	for (i = 0; i < ss.size(); i++)
	{
		sumall += cost[i];
	}
	for (i = 1; i <= nver; i++)
	{
		GetResval(i);
	}
	for (i = 1; i <= nver; i++) vercost[i] = resval[i];
	#ifdef FTC_DEBUG
	out << "Vertex cost:\n";
	for (i = 1; i <= nver; i++) out << vercost[i] << " ";
	out << "\n";
	#endif
	for (i = 1; i <= nver; i++)
	{
		res[n][i] = 0;
	}
	for (i = n - 1; i >= 0; i--)
	{
		for (j = 1; j <= nver; j++)
		{
			for (k = 0; k < 26; k++)
			{
				int nj = go[j][k];
				if (res[i + 1][nj] == -1) continue;
				if (res[i][j] < res[i + 1][nj] + vercost[nj])
				{
					res[i][j] = res[i + 1][nj] + vercost[nj];
					rsym[i][j] = k;
				}
			}
		}
	}
	string rs = "";
	out << res[0][1] << "\n";
	int cj = 1;
	for (i = 0; i < n; i++)
	{
		rs += (char)(rsym[i][cj] + 'a');
		cj = go[cj][rsym[i][cj]];
	}
	out << rs;
	#ifdef FTC_DEBUG
	out << "\n";
	int64 resbea = 0;
	for (i = 0; i < n; i++)
	{
		for (j = 0; j < ss.size(); j++)
		{
			if (i + ss[j].length() - 1 < n)
			{
				int f = 0;
				for (k = 0; k < ss[j].length(); k++)
				{
					if ((rs[i + k] - 'a') != ss[j][k]) f = 1;
				}
				if (f == 0) resbea += cost[j];
			}
		} 
	}
	out << "\n" << resbea;
	#endif
	#ifdef FTC_DEBUG
/*	int curver = 1;
	for (i = 0; i < n; i++)
	{
		curver = go[curver][rs[i] - 'a'];
		if (vercost[curver] != 0)
		{
			string t = "";
			for (j = curver; j != 1; j = rt[j])
			{
				t += (char)(sym[j] + 'a');
			}
			reverse(t.begin(), t.end());
			out << "Found at pos " << i << " string: " << t << "\n";
		}
	}*/
	#endif
}

int main()
{
	Load();
	Solve();
	return 0;
}       