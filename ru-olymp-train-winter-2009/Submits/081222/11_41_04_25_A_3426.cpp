#include "vector"
#include "fstream"
#include "iostream"
#include "math.h"
#include "stdio.h"
#include "algorithm"
#include "string"

using namespace std;
int k;

struct tree{
	int a[262146][5];
	int plus[262146];
	int shift;
	tree()
	{
		shift = 131072;
		for(int i = 1; i <= 262144;plus[i]=0,i++)
			for(int j = 0; j < 5; j++)
			{
				a[i][j] = 0;
				if(i >= shift && j == 0)
					a[i][j] = 1;
			}
		for(int i = shift-1; i >= 1; i--)
		{
			a[i][0] = a[i*2][0] + a[i*2+1][0];
			//printf("%d    %d\n", i, a[i][0]);
		}
		
	}
	void pl(int l, int r, int gl=0,int gr=131071, int i=1)
	{
		//printf("plus %d %d %d %d %d\n", l, r, gl, gr, i);
		if(i >= 262144)return;
		if(r < gl || l > gr)return;
		if(l <= gl &&r >= gr)
		{
			plus[i] += 1;
			//printf("plused %d %d\n", gl, gr);
			return;
		}
		int tm[5];
		tm[0] = 0;
		for(int j = 0; j < k; j++)
			tm[j] = get(i, j);
		for(int j = 0; j < k; j++)
			a[i][j] = tm[j];
		if(i*2+1 <= 262144)
		{
			plus[i*2] += plus[i];
			plus[i*2+1] += plus[i];
			plus[i] = 0;
		}		
		pl(l, r, gl, (gl+gr)/2, i*2);
		pl(l, r, (gl+gr)/2+1, gr, i*2+1);
		for(int j = 0; j < 5; j++)
		{
			a[i][j] = get(i*2, j) + get(i*2+1, j);
		}
	}
	int get(int i, int j)
	{
		return a[i][(j+k*k*k*k*k*k-plus[i])%k];
	}
	int cnt(int l, int r, int gl=0,int gr=131071, int i=1)
	{
		//printf("cnt %d %d %d %d %d\n", l, r, gl, gr, i);
		if(i >= 262144)return 0;
		if(r < gl || l > gr)return 0;
		if(l <= gl &&r >= gr)
		{
			//printf("FOUND ");
			int res = 0;
			for(int j = 0; j < k; j++)
				res += get(i,j)*j;
			//printf("%d\n", res);
			return res;
		}
		int tm[5];
		tm[0] = 0;
		for(int j = 0; j < k; j++)
			tm[j] = get(i, j);
		for(int j = 0; j < k; j++)
			a[i][j] = tm[j];
		if(i*2+1 <= 262144)
		{
			plus[i*2] += plus[i];
			plus[i*2+1] += plus[i];
			plus[i] = 0;
		}		
		return cnt(l, r, gl, (gl+gr)/2, i*2) + cnt(l, r, (gl+gr)/2+1, gr, i*2+1);
	}
};
tree t;
int main()
{
	int n, m;
	ifstream fin("sum.in");
	freopen("sum.out", "wt", stdout);	
	fin >> n >> k >> m;
	//printf("%d", t.get(1,0));
	for(int i = 0; i< m; i++)
	{
		int a,b,c;
		fin >> a >> b >> c;
		if(a == 1)
		{
			t.pl(b-1,c-1);
			//cout << t.cnt(b-1,c-1) << "!!\n";
		}
		else
		{
			cout << t.cnt(b-1, c-1) <<endl;
		}
	}
	
	return 0;
}