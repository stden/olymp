#include "vector"
#include "fstream"
#include "iostream"
#include "math.h"
#include "algorithm"
#include "string"

using namespace std;

ifstream fin("code.in");
//ofstream fout("code.out");

struct elem{
	elem * l, *r;
	elem * p;
	int h;
	elem() :l(0), r(0), p(0),sum(0), h(0){}
	int sum;

	void print(string s)
	{
		if(l == 0 && r == 0)
			cout << s << endl;
		else
			l->print(s+"0");
		if(r)r->print(s+"1");
	}
	void print()
	{
		print(string());
	}
	
};

int main()
{
	freopen("code.out", "wt", stdout);
	elem * root = new elem;
	elem * now= root;
	int s= 0;
	int n;
	int a[100001];
	fin >> n;
	for(int i = 0; i < n; i++)
	{
		fin >> a[i];	
	}
	if(n == 1)
	{
		cout << 0;
		return 0;
	}
	root-> l = new elem;
	root-> l->h = 1;
	root-> l->p = root;
	root-> l->sum = a[0];
	root-> r = new elem;
	root-> r->h = 1;
	root-> r->p = root;
	root-> r->sum = a[1];
	root->sum = a[0]+a[1];
	now = root->r;
	for(int i =	2 ;i < n ;i++)
	{
		//printf("%d\n", i);
		elem * mne = 0;
		int mn= 2000000000;
		elem * ne = now;
		while(ne != 0)
		{
			int ss = a[i]*(ne->h+1)+ne->sum;
			//cout << ss << " ";
			if(ss <= mn)
			{
				mn= ss;
				mne = ne;
			}
			ne = ne->p;
		}
		if(mne == root)
		{
			elem * u = new elem;
			u->l = root;
			root->p = u;
			u->r = new elem;
			u->sum = root->sum + a[i];
			u->r->sum = a[i];
			u->r->p = u;
			u->h = 0;
			u->r->h = 1;
			now = u->r;
			root = u;
		}
		else
		{
			ne = mne;
			elem * u = new elem;
			u->l = ne;
			u->p = ne->p;
			ne->p->r = u;
			ne->p = u;
			u->r = new elem;
			u->r->sum = a[i];
			u->sum = u->l->sum;
			u->r->p = u;
			u->h = ne->h;
			u->r->h = u->h+1;
			while(ne != 0)
			{
				ne->sum += a[i]; 
				ne= ne->p;
			}
			now = u->r;
		}
	}
	root->print();
	return 0;
}