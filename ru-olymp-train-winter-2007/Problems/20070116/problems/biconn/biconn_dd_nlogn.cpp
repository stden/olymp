#include <fstream>
#include <iostream>
#include <vector>
#include <set>
using namespace std;

#pragma comment (linker, "/STACK:20000000")

ifstream in("biconn.in");
ofstream out("biconn.out");

const int MAXN = 50000;

class Edge
{
public:
	int be, en;
};

vector <Edge> edg;
int n;
int next[20 * MAXN + 1];
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

int dsurt[MAXN + 1];

int Root(int ver)
{
	if (ver == 0) return 0;
	if (dsurt[ver] != ver) dsurt[ver] = Root(dsurt[ver]);
	return dsurt[ver];
}

int rt[MAXN + 1];
int kmark[MAXN + 1];
int leafmark[MAXN + 1];

int FindLeaf(int ver)
{
	int cur = ver;
	while (1)
	{
		leafmark[cur] = 1;
		int i = first[cur];
		while ((i != -1) && (( Root(edg[i].en) == cur) || (Root(edg[i].en) == Root(rt[cur])))) i = next[i];
		if (i != -1) cur = Root(edg[i].en);
		else return cur;
	}
}

int FindLeaf2(int ver, int &ifwas)
{
	int cur = ver;
	while (1)
	{
		leafmark[cur] = 1;
		if (cur == ifwas) 
		{
			ifwas = -2;
			return 0;
		}
		int i = first[cur];
		while ((i != -1) && (( Root(edg[i].en) == cur) || (Root(edg[i].en) == Root(rt[cur])))) i = next[i];
		if (i != -1) cur = Root(edg[i].en);
		else return cur;
	}
}

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

class Vertex
{
public:
	int id, pow;
};

bool operator<(Vertex a, Vertex b)
{
	if (a.pow < b.pow) return true;
	else if (a.pow > b.pow) return false;
	if (a.id < b.id) return true;
	else if (a. id > b.id) return false;
	return false;
}

void Solve()
{
	vector<pair<int, int> > ans;
	int i;
	OrderTree(1);
	int deg1 = CountDeg();
	set<Vertex> vert;
	vert.clear();
	memset(kmark, 0, sizeof(kmark));
	for (i = 1; i <= n; i++)
	{
		Vertex a;
		a.id = i;
		a.pow = deg[i];
		vert.insert(a);
		dsurt[i] = i;
	}
	while (deg1 > 0)
	{
		Vertex a = *(--vert.end());
		int currt, v1, v2;
		if (a.pow > 3)
		{
			currt = a.id;
			int j;
			j = first[a.id];
			while ( ( Root(edg[j].en) == a.id) || (Root(edg[j].en) == Root(rt[a.id])) ) j = next[j];
			v1 = FindLeaf( Root(edg[j].en) );
			j = next[j];
			while ( ( Root(edg[j].en) == a.id) || (Root(edg[j].en) == Root(rt[a.id])) ) j = next[j];
			v2 = FindLeaf( Root(edg[j].en) );
		}
		else if (a.pow == 3)
		{
			Vertex sec = *(--(--vert.end()));
			if (sec.pow != 3)
			{
				currt = a.id;
				int j;
				j = first[a.id];
				while ( ( Root(edg[j].en) == a.id) || 
							(Root(edg[j].en) == Root(rt[a.id])) ) j = next[j];
				v1 = FindLeaf( Root(edg[j].en) );
				j = next[j];
				while ( ( Root(edg[j].en) == a.id) || 
						(Root(edg[j].en) == Root(rt[a.id])) ) j = next[j];
				v2 = FindLeaf( Root(edg[j].en) );
			}
			else
			{
				int j;
				j = first[a.id];
				while ( (leafmark[Root(edg[j].en)] == 1) || ( Root(edg[j].en) == a.id) || (Root(edg[j].en) == Root(rt[a.id])) ) j = next[j];
				int ff = sec.id;
				v1 = FindLeaf2( Root(edg[j].en), ff );
				if (ff == -2)
				{
					v1 = FindLeaf( sec.id );
					j = next[j];
					while ( (leafmark[Root(edg[j].en)] == 1) || ( Root(edg[j].en) == a.id) || (Root(edg[j].en) == Root(rt[a.id])) ) j = next[j];
					v2 = FindLeaf( Root(edg[j].en) );
				}
				else
				{
					ff = a.id;
					j = first[sec.id];
					while ( (leafmark[Root(edg[j].en)] == 1) || ( Root(edg[j].en) == sec.id) || (Root(edg[j].en) == Root(rt[sec.id])) ) j = next[j];
					v2 = FindLeaf2( Root(edg[j].en), ff );
					if (ff == -2)
					{
						j = next[j];
						while ( (leafmark[Root(edg[j].en)] == 1) || ( Root(edg[j].en) == sec.id) || (Root(edg[j].en) == Root(rt[sec.id])) ) j = next[j];
						v2 = FindLeaf( Root(edg[j].en) );
					}
				}
				kmark[v1] = deg1;
				kmark[v2] = deg1;
				int wv1 = v1, wv2 = v2;
				int cur = 0;
				while (1)
				{
					if (cur == 0)
					{
						if (v1 != 0)
						{
							v1 = Root(rt[v1]);
							if ((v1 != 0) && (kmark[v1] == deg1))
							{
								currt = v1;
								break;
							}
							kmark[v1] = deg1;
						}
					}
					else
					{
						if (v2 != 0)
						{
							v2 = Root(rt[v2]);
							if ((v2 != 0) && (kmark[v2] == deg1))
							{
								currt = v2;
								break;
							}
							kmark[v2] = deg1;
						}
					}
					cur = 1 - cur;
				}
				v1 = wv1;
				v2 = wv2;
			}
		}
		else if (a.pow < 3)
		{
			Vertex a;
			Vertex b;
			a = *(vert.begin());
			b = *(++vert.begin());
			ans.push_back(make_pair(a.id, b.id));
			break;
		}
		int cur = v1;
		int newrtdeg = 0;
		while (cur != currt)
		{
			if (cur == currt) break;
		    a.id = cur;
		    a.pow = deg[cur];
		    vert.erase(a);
			kmark[cur] = 1;
			newrtdeg += deg[cur] - 2;
			cur = Root(rt[cur]);
		}
		cur = v2;
		while (cur != currt)
		{
			if (cur == currt) break;
			a.id = cur;
		    a.pow = deg[cur];
		    vert.erase(a);
		    kmark[cur] = 1;
			newrtdeg += deg[cur] - 2;
			cur = Root(rt[cur]);
		}
		cur = currt;
		a.id = cur;
		a.pow = deg[cur];
		vert.erase(a);
		newrtdeg += deg[cur] - 2;
		kmark[currt] = 0;
		leafmark[currt] = 0;
		ans.push_back(make_pair(v1, v2));
		a.id = currt;
		a.pow = newrtdeg + 2;
		vert.insert(a);
		deg[currt] = newrtdeg + 2;

		cur = v1;
		while (cur != currt)
		{
			for (i = first[cur]; i != -1; i = next[i])
			{
				if (Root(edg[i].en) == Root(rt[cur])) continue;
				if (Root(edg[i].en) == currt) continue;
				if (kmark[Root(edg[i].en)] == 0)
				{
					Edge a;
					a.be = currt;
					a.en = Root(edg[i].en);
					AddEdge(a);
				}
			}
			cur = Root(rt[cur]);
		}
		cur = v2;
		while (cur != currt)
		{
			for (i = first[cur]; i != -1; i = next[i])
			{
				if (Root(edg[i].en) == Root(rt[cur])) continue;
				if (Root(edg[i].en) == currt) continue;
				if (kmark[Root(edg[i].en)] == 0)
				{
					Edge a;
					a.be = currt;
					a.en = Root(edg[i].en);
					AddEdge(a);
				}
			}
			cur = Root(rt[cur]);
		}	
		
		cur = v1;
		while (cur != currt)
		{
			dsurt[Root(cur)] = Root(currt);
			cur = Root(rt[cur]);
		}
		cur = v2;
		while (cur != currt)
		{
			dsurt[Root(cur)] = Root(currt);
			cur = Root(rt[cur]);
		}

		//clear leak edges in currt's list
		int prv = -1;
		for (i = first[currt]; i != -1; i = next[i])
		{
			if (Root(edg[i].en) == currt)
			{
				if (prv == -1) first[currt] = next[i];
				else next[prv] = next[i];
			}
			prv = i;
		}
		deg1 -= 2;
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