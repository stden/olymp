#include <fstream>
#include <vector>
using namespace std;

ifstream in("biconn.in");
ofstream out("biconn.out");

const int MAXN = 1000;

class Edge
{
public:
	int be, en;
};

vector <Edge> edg;
int n;
int next[2 * MAXN + 1];
int first[MAXN + 1];

void AddEdge(Edge a)
{
	edg.push_back(a);
	next[edg.size() - 1] = first[a.be];
	first[a.be] = edg.size() - 1;
}

void Load()
{
	memset(first, 0xFF, sizeof(first));
	in >> n;
	int i;
	for (i = 2; i <= n; i++)
	{
		Edge a;
		in >> a.be >> a.en;
		AddEdge(a);
		int t = a.be;
		a.be = a.en;
		a.en = t;
		AddEdge(a);
	}
}

int deg[MAXN + 1];

int CountDeg()
{
	int i;
	int res = 0;
	for (i = 1; i <= n; i++)
	{
		deg[i] = 0;
		int j = first[i];
		while (j != -1)
		{
			deg[i]++;
			j = next[j];
		}
		if (deg[i] == 1) res++;
	}
	return res;
}

int rt[MAXN + 1];

void OrderTree(int ver)
{
	int i;
	for (i = first[ver]; i != -1; i = next[i])
	{
		if (edg[i].en == rt[ver]) continue;
		rt[edg[i].en] = ver;
		OrderTree(edg[i].en);
	}
}

int FindLeaf(int ver)
{
	int cur = ver;
	while (1)
	{
		int i = first[cur];
		if (edg[i].en == rt[cur]) i = next[i];
		if (i != -1) cur = edg[i].en;
		else return cur;
	}
}

int IsParent(int v1, int v2)
{
	int cur;
	for (cur = v1; cur != 0; cur = rt[cur])
	{
		if (cur == v2) return 1;
	}
	return 0;
}

int somever[MAXN + 1];

void RebuildFirstNext()
{
	memset(first, 0xFF, sizeof(first));
	int i;
	for (i = 0; i < edg.size(); i++)
	{
		if (edg[i].be == edg[i].en) next[i] = -1;
		else
		{
			next[i] = first[edg[i].be];
			first[edg[i].be] = i;
		}
	}
}

int killver[MAXN + 1];

void Solve()
{
	vector<pair<int, int> > ans;
	int i;
	for (i = 1; i <= n; i++)
	{
		somever[i] = i;
	}
	int deg1 = CountDeg();
	while (deg1 != 0)
	{
		int mi = 0, mx = -1, nummx = 0, mi2 = 0;
		for (i = 1; i <= n; i++)
		{
			if (deg[i] > mx)
			{
				mx = deg[i];
				mi = i;
				nummx = 1;
			}
			else if (deg[i] == mx)
			{
				nummx++;
				mi2 = i;
			}
		}
		int v1, v2;
		if (deg1 == 2)
		{
			v1 = 0;
			for (i = 1; i <= n; i++)
			{
				if (deg[i] == 1)
				{
					if (v1 == 0) v1 = i;
					else v2 = i;
				}
			}
		}
		else if (mx > 3)
		{
			rt[mi] = 0;
			OrderTree(mi);
			i = first[mi];
			v1 = FindLeaf(edg[i].en);
			i = next[i];
			v2 = FindLeaf(edg[i].en);
		}
		else
		{
			rt[mi] = 0;
		    OrderTree(mi);
		    if (nummx == 1)
		    {
		    	i = first[mi];
				v1 = FindLeaf(edg[i].en);
				i = next[i];
				v2 = FindLeaf(edg[i].en);
		    }
		    else
		    {
		    	i = first[mi];
		    	if (IsParent(edg[i].en, mi2))
		    	{
		    		i = next[i];
		    	}
				v1 = FindLeaf(edg[i].en);
				v2 = FindLeaf(mi2);
		    }
		}
		memset(killver, 0, sizeof(killver));
		for (i = v1; i != 0; i = rt[i]) killver[i] = 1;
		for (i = v2; i != 0; i = rt[i]) killver[i] = 1;
		ans.push_back(make_pair(somever[v1], somever[v2]));
		int i;
		int newnum = mi;
		for (i = 0; i < edg.size(); i++)
		{
			if (killver[edg[i].be]) edg[i].be = newnum;
			if (killver[edg[i].en]) edg[i].en = newnum;
		}
		RebuildFirstNext();
		deg1 = CountDeg();
	}
	out << ans.size() << "\n";
	for (i = 0; i < ans.size(); i++)
	{
		out << ans[i].first << " " << ans[i].second << "\n";
	}
}

int main()
{
	Load();
	Solve();
	return 0;
}