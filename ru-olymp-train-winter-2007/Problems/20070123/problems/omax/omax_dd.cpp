#include <fstream>
#include <iostream>
#include <vector>
#include <cstdio>
using namespace std;

const int MAXN = 100000;
const int MAXM = 300000;

class Edge
{
public:
	int be, en;
};

int n;
int first[MAXN + 1], first2[MAXN + 1];
vector<Edge> edg;
vector<int> next, next2;
int nedg;

void AddEdge(int v1, int v2)
{
	Edge a;
	a.be = v1;
	a.en = v2;
	edg.push_back(a);
	next.push_back(first[v1]);
	next2.push_back(first2[v2]);
	first[v1] = edg.size() - 1;
	first2[v2] = edg.size() - 1;
}

void Load()
{
	memset(first, 0xFF, sizeof(first));
	memset(first2, 0xFF, sizeof(first2));
	scanf("%d", &n);
	int i;
	for (i = 1; i <= n; i++)
	{
		int j, k;
		scanf("%d", &k);
		for (j = 0; j < k; j++)
		{
			int q;
			scanf("%d", &q);
			AddEdge(i, q);
		}
	}
}

vector<int> vdeg1;
int deg1[MAXN + 1], deg2[MAXN + 1];
int match[MAXN + 1], rmatch[MAXN + 1];

void Solve()
{
	vdeg1.clear();
	int i;
	for (i = 0; i < edg.size(); i++)
	{
		deg1[edg[i].be]++;
		deg2[edg[i].en]++;
	}
	int num = 0;
	//////////////////////////////////////////////
	// left part
	for (i = 1; i <= n; i++)
	{
		if (deg1[i] == 1)
		{
			vdeg1.push_back(i);
		}
	}
	i = 0;
	while (i < vdeg1.size())
	{
		int cur = vdeg1[i];
		int j;
		int nxt = -1;
		for (j = first[cur]; j != -1; j = next[j])
		{
			if (match[edg[j].en] == 0)
			{
				nxt = edg[j].en;
				break;
			}
		}
		if (nxt == -1) 
		{
			printf("NO\n");
			cerr << "after " << num << " steps\n";
			return;
		}
		match[nxt] = cur;
		rmatch[cur] = nxt;
		deg2[nxt] = 0;
		deg1[cur] = 0;
		num++;
		for (j = first2[nxt]; j != -1; j = next2[j])
		{
			deg1[edg[j].be]--;
			if (deg1[edg[j].be] == 1)
			{
				vdeg1.push_back(edg[j].be);
			}	
		}
		i++;
	}
	//////////////////////////////////////////////////
	// right part
	vdeg1.clear();
	for (i = 1; i <= n; i++)
	{
		if (deg2[i] == 1)
		{
			vdeg1.push_back(i);
		}
	}
	i = 0;
	while (i < vdeg1.size())
	{
		int cur = vdeg1[i];
		int j;
		int nxt = -1;
		for (j = first2[cur]; j != -1; j = next2[j])
		{
			if (rmatch[edg[j].be] == 0)
			{
				nxt = edg[j].be;
				break;
			}
		}
		if (nxt == -1) 
		{
			printf("NO\n");
			cerr << "after " << num << " steps\n"; 
			return;
		}
		match[cur] = nxt;
		rmatch[nxt] = cur;
		deg1[nxt] = 0;
		deg2[cur] = 0;
		num++;
		for (j = first[nxt]; j != -1; j = next[j])
		{
			deg2[edg[j].en]--;
			if (deg2[edg[j].en] == 1)
			{
				vdeg1.push_back(edg[j].en);
			}	
		}
		i++;
	}
	if (num != n)
	{
		printf("NO\n");
		cerr << "after " << num << " steps\n";
	}
	else
	{
		for (i = 1; i <= n; i++)
		{
			rmatch[match[i]] = i;
		}
		printf("YES\n");
		for (i = 1; i <= n; i++) printf("%d ", rmatch[i]);
		printf("\n");
	}
}

int main()
{
	freopen("omax.in", "rt", stdin);
	freopen("omax.out", "wt", stdout);
	Load();
	Solve();
	return 0;
}