#include "treeunit.h"
#include "vector"
#include "fstream"
#include "math.h"
#include "algorithm"

using namespace std;

ifstream fin("armor.in");
ofstream fout("armor.out");
typedef pair<int ,int> PII ;
int a[60][10];
int s[60][10];

int n, m, k, v;

vector<pair<int,int> > ways[60];

int cur_min = 2000000000;
vector<int> skid;
vector<bool> b;

int w[60][60] = {0};
int alb = 0;

void cn()
{
	for(int k = 0; k < n; k++)
		for(int i = 0; i < n; i++)
			for(int j = 0; j < n; j++)
				w[i][j] = min(w[i][j], w[i][k] + w[k][j]);
}

int perebor(int i, int cur_c, int bought, vector<bool> was, bool djb)
{	
	if(was[i] == 1)
	{
		return-1;
	}
	was[i] = 1;
	if(cur_c > cur_min)return cur_min;
	if(bought == alb)
	{
		cur_min = min(cur_c + w[i][v-1], cur_min);
		return cur_c + w[i][v-1];
	}
	int mnt = -1;
	vector<bool> no;
	if(!b[i])
	for(int j = 0; j < k; j++)
	{
		if(((1<<j) & bought) == 0)
		{
			skid[i] += s[i][j];
			no = vector<bool>(n);
			int t = perebor(i, cur_c+a[i][j]/100*(100-skid[i]+s[i][j]), bought | (1<<j), no, 1);
			skid[i] -= s[i][j];
			if(t != -1)
				if(mnt == -1)
					mnt = t;
				else if(mnt > t)
					mnt = t;
		}
	}
	for(int j = 0; j < ways[i].size(); j++)
	{
		int bb = ways[i][j].first;
		int c = ways[i][j].second;
		if(djb)
			b[i] = 1;
		int t = perebor(bb, cur_c+c, bought, was, 0);
		if(t != -1)
			if(mnt == -1)
				mnt = t;
			else if(mnt > t)
				mnt = t;
	}
	if(djb)
		b[i] = 0;
	if(mnt != -1)
		cur_min = min(mnt, cur_min);
	return mnt;
}

int main()
{
	bool can[10] = {0};
	fin >> n >> m >> k >> v;
	skid = vector<int> (n);
	b = vector<bool>(n);
	alb = 1 << k;
	alb--; 
	for(int i = 0; i < n; i++)
	{
		for(int j = 0; j < k; j++)
		{
			fin >> a[i][j];
			fin >> s[i][j];
		}
	}
	for(int i = 0; i < n; i++)
	{
		for(int j = 0; j < n; j++)
			w[i][j] = cur_min;
		w[i][i] = 0;
	}
	for(int i = 0; i < m; i++)
	{
		int a, b, c;
		fin >> a >> b >> c;
		a--, b--;
		ways[a].push_back(PII(b, c));		
		ways[b].push_back(PII(a, c));
		w[a][b] = w[b][a] = c;
	}
	cn();
	vector<bool> was(n);
	int t = perebor(v-1, 0, 0, was, 0);
	printf("T = %d !!!!!!!!!", t);
	fout << t;

	return 0;
}