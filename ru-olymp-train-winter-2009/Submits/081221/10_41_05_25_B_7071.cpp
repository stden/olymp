#include "treeunit.h"
#include "vector"
#include "iostream"
#include "math.h"

using namespace std;
int n;
int best = -1;
struct way{
 int w[2];
  int cnt[2];
  way(){cnt[0]=cnt[1]=0;u=1;}
  bool u;
};

int abs(int u)
{
	if(u < 0)
		return -u;
	return u;
}

struct ww{
  way * w;
  int num;
};

vector<ww> ways[200001];
int u[200001]= {0};
int ucc = 1;
int countAll(int i)
{
	//printf("dfs from %d", i);
	int res = 0;
	if(u[i] != ucc)
  	{
		res = 1;
    	u[i] = ucc;
		for(int j = 0; j < ways[i].size(); j++)
    	{
			//printf("way %d %d\n", ways[i][j].w->w[0], ways[i][j].w->w[1]);
			//printf("num = %d\n", ways[i][j].num);
			if(ways[i][j].w->u)
			{
				int y = countAll(ways[i][j].w->w[ways[i][j].num^1]);
				//printf("way %d %d\n", ways[i][j].w->w[0], ways[i][j].w->w[1]);
				//printf("num = %d\n", ways[i][j].num);
				//printf("y=%d\n", y);
				if(y != 0)
				{
					ways[i][j].w->cnt[ways[i][j].num] = y;
					ways[i][j].w->cnt[ways[i][j].num^1] = n-y;
					res += ways[i][j].w->cnt[ways[i][j].num];
					//printf("n = %d\n", n);
					//printf("edge %d -> %d    %d %d\n", ways[i][j].w->w[0], ways[i][j].w->w[1], ways[i][j].w->cnt[0], ways[i][j].w->cnt[1]);
				}
			}      
    	}
	}
	//printf("end dfs from %d", i);
	return res;
}
int countN(int i)
{
	int res = 0;
//printf("dfs grom %d\n", i);
  if(u[i] != ucc)
  {
	res = 1;
    u[i] = ucc;
    for(int j = 0; j < ways[i].size(); j++)
    {
		//printf("way %d %d\n", ways[i][j].w->w[0], ways[i][j].w->w[1]);
		//printf("num = %d\n", ways[i][j].num);
		if(ways[i][j].w->u)
		{
			res += countN(ways[i][j].w->w[ways[i][j].num^1]);	
		}      
    }
  }
  return res;
}



int main()
{
	way* ws[200001];
  	init();
	printf("inited");

  n = getN();
	int cn = n;
	for(int i = 0;i < 200000; ws[i++] = new way);
	
  for(int i = 1 ;i < n; i++)
  {
    int a = getA(i);
    int b = getB(i);
    a--, b--;
	//printf("edge %d %d -> %d\n", i, a, b);
    ws[i-1]->w[0] = a;
	ws[i-1]->w[1] = b;
    ww wa;
    wa.w = ws[i-1];
    wa.num = 0;
	ways[a].push_back(wa);
    ww wb;
    wb.w = ws[i-1];
    wb.num = 1;    
    ways[b].push_back(wb);
  }
  int vertex = 0;
  while(n > 1)
  {
	best = -1;
	for(int i = 0; i < cn-1; i++)
		ws[i]->cnt[0] = ws[i]->cnt[1] = 0;
	countAll(vertex);
	for(int i = 0; i < cn-1; i++)
	{
		if(ws[i]->cnt[0] != 0)
		{
			if(best == -1)
				best = i;
			else
				if(abs(ws[i]->cnt[0] - ws[i]->cnt[1]) < abs(ws[best]->cnt[0] - ws[best]->cnt[1]))
					best = i;
		}
	}
	int t = query(best+1);
	vertex = ws[best]->w[t];
	ws[best]->u = 0;
	ucc++;
    n = countN(vertex);
	ucc++;
  }
  report(vertex+1);
  
  return 0;
}