#include <fstream>
#include <iostream>
#include <vector>
using namespace std;

#pragma comment(linker, "/STACK:20000000")

#define FTC_DEBUG
#undef FTC_DEBUG

const int MAXN = 100000;
const int MAXM = 200000;  // THIS IS ONLY FOR CHECKING REAL NUMBER IS 2 TIMES LESS!!!

ifstream in("republic.in");
ofstream out("republic.out");

class Edge
{
public:
	int be, en;
};

inline void Swap(int &a, int &b)
{
	int t = a;
	a = b;
	b = t;
}

int nver;
vector<Edge> edg;
int next[MAXM];
int first[MAXN + 1];
int rfirst[MAXN + 1];
int rnext[MAXM];

void BuildFirstNext()
{
	memset(first, 0xFF, sizeof(first));
	memset(rfirst, 0xFF, sizeof(rfirst));
	int i;
	for (i = 0; i < edg.size(); i++)
	{
		next[i] = first[edg[i].be];
		first[edg[i].be] = i;
		rnext[i] = rfirst[edg[i].en];
		rfirst[edg[i].en] = i;
	}
}

void Load()
{
	int i, m;
	in >> nver >> m;
	for (i = 0; i < m; i++)
	{
		Edge a;
		in >> a.be >> a.en;
		edg.push_back(a);
	}
	BuildFirstNext();
}

int ind[MAXN + 1];
int was[MAXN + 1];
int ctop;

void DfsTop(int ver)
{
	was[ver] = 1;
	int i;
	for (i = first[ver]; i != -1; i = next[i])
	{
		if (was[edg[i].en] == 0) DfsTop(edg[i].en);
	}
	ctop++;
	ind[ctop] = ver;
}

int nc[MAXN + 1];
int ccom;

void DfsCom(int ver)
{
	nc[ver] = ccom;
	int i;
	for (i = rfirst[ver]; i != -1; i = rnext[i])
	{
		if (nc[edg[i].be] == 0) DfsCom(edg[i].be);
	}
}

vector<Edge> tedg;
int somever[MAXN + 1];

void CompressCompo()
{
	memset(was, 0, sizeof(was));
	int i;
	ctop = 0;
	for (i = 1; i <= nver; i++)
	{
		if (was[i] == 0)
		{
			DfsTop(i);
		}
	}
	memset(nc, 0, sizeof(nc));
	ccom = 0;
	for (i = nver; i >= 1; i--)
	{
		if (nc[ind[i]] == 0)
		{
			ccom++;
			DfsCom(ind[i]);
		}
	}
	#ifdef FTC_DEBUG
	out << "Counted components:\n";
	for (i = 1; i <= nver; i++) out << nc[i] << " ";
	out << "\n";
	#endif
	tedg.clear();
	for (i = 0; i < edg.size(); i++)
	{
		if (nc[edg[i].be] != nc[edg[i].en])
		{
			Edge a;
			a.be = nc[edg[i].be];
			a.en = nc[edg[i].en];
			tedg.push_back(a);
		}
	}                                                                 
	edg.clear();
	for (i = 0; i < tedg.size(); i++) edg.push_back(tedg[i]);
	for (i = nver; i >= 1; i--) somever[nc[i]] = i;
	BuildFirstNext();
	nver = ccom;
	#ifdef FTC_DEBUG
	out << "Components compressed got:\n nver = " << nver << "\n";
	out << "Edges: \n";
	for (i = 0; i < edg.size(); i++)
	{
		out << edg[i].be << " " << edg[i].en << "\n";
	}
	#endif
}

int degin[MAXN + 1], degout[MAXN + 1];

void CountDeg()
{
	int i;
	memset(degin, 0, sizeof(degin));
	memset(degout, 0, sizeof(degout));
	for (i = 0; i < edg.size(); i++)
	{
		degin[edg[i].en]++;
		degout[edg[i].be]++;
	}
}

vector<Edge> ans;

vector<int> src;
vector<int> sink;
vector<int> isol;

void Solve()
{
	CompressCompo();
	CountDeg();
	int i;
	int numisol = 0, numsink = 0, numsrc = 0;
	for (i = 1; i <= nver; i++)
	{
		if ((degin[i] == 0) && (degout[i] == 0))
		{
			numisol++;
		}
		else if (degin[i] == 0)
		{
			numsrc++;
		}
		else if (degout[i] == 0)
		{
			numsink++;
		}
	}
	int revflag = 0;
	if (numsrc > numsink)
	{
		revflag = 1;
		int i;
		for (i = 0; i < edg.size(); i++)                           
		{
			Swap(edg[i].be, edg[i].en);
		}
		BuildFirstNext();
		Swap(numsrc, numsink);
		for (i = 1; i <= nver; i++) Swap(degin[i], degout[i]);
	}
	src.clear();
	sink.clear();
	isol.clear();
	for (i = 1; i <= nver; i++)
	{
		if ((degin[i] == 0) && (degout[i] == 0))
		{
			isol.push_back(i);
		}
		else if (degin[i] == 0)
		{
			src.push_back(i);
		}
		else if (degout[i] == 0)
		{
			sink.push_back(i);
		}
	}
	for (i = 0; i < src.size() - 1; i++)
	{
		Edge a;
		a.be = sink[i];
		a.en = src[i + 1];
		edg.push_back(a);
		a.be = somever[a.be];
		a.en = somever[a.en];
		if (revflag == 1) Swap(a.be, a.en);
		ans.push_back(a);
	}
	int prev = sink[src.size() - 1];
	for (i = src.size() - 1; i < sink.size() - 1; i++)
	{
		Edge a;
		a.be = prev;
		a.en = sink[i + 1];
		prev = sink[i + 1];
		edg.push_back(a);
		a.be = somever[a.be];
		a.en = somever[a.en];
		if (revflag == 1) Swap(a.be, a.en);
		ans.push_back(a);
	}
	for (i = 0; i < isol.size(); i++)
	{
		Edge a;
		a.be = prev;
		a.en = isol[i];
		prev = isol[i];
		edg.push_back(a);
		a.be = somever[a.be];
		a.en = somever[a.en];
		if (revflag == 1) Swap(a.be, a.en);
		ans.push_back(a);
	}
	Edge a;
	a.be = prev;
	a.en = src[0];
	edg.push_back(a);
	a.be = somever[a.be];
	a.en = somever[a.en];
	if (revflag == 1) Swap(a.be, a.en);
	ans.push_back(a);
	BuildFirstNext();
	////////////////////////////////////////////////////////////
	// Now we can output answer
	out << ans.size() << "\n";
	for (i = 0; i < ans.size(); i++)
	{
		out << ans[i].be << " " << ans[i].en << "\n";
	}
	////////////////////////////////////////////////////////////
	// More than that, we can check number of components
	CompressCompo();
	if ((nver == 1) && (edg.size() == 0))
	{
		cout << "OK " << ans.size() << "\n";
	}
	else
	{
		cout << "Botva appeared!!!\n";
	}
}

int main()
{
	Load();
	Solve();
	return 0;
}
