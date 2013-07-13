#include "vector"
#include "fstream"
#include "iostream"
#include "math.h"
#include "stdio.h"
#include "algorithm"
#include "string"
#include "stdlib.h"

using namespace std;
/*
struct elem{
	elem*l, *r;
	int size;
	int y;
	int val;
	void rec()
	{
		size = l->size+r->size+1;
	}
};

struct tree2{
	elem *root;
	elem no;
	tree2()
	{
		no.l=no.r=&no;
		no.size=0;
	}
	elem * ne()
	{
		elem * u = new elem;
		u->l=&no;
		u->r=&no;
		u->size=0;
		u->val = 0;
		u->y = rand()*rand();
		return u;
	}
	void split(elem * v, elem * a)
	{
		if(v->size == 0){a->l=a->r=&no;return;}
		if(v->val <= a->val)
		{
			split(v->r, a);
			v->r = a->l;
			a->l = v;
		}
		else
		{
			split(v->l, a);
			v->l = a->r;
			a->r = v;
		}
		a->rec();
	}
	elem * merge(elem * a, elem * b)
	{
		if(a->size==0)return b;
		if(b->size==0)return a;
		if(a->y < b->y)
		{
			a->r = merge(a->r, b);
			return a;
		}
		else
		{
			b->l = merge(a, b->l);
			return b;
		}
	}
};*/

struct tree{
	//tree2 tr[400005];
	int size[400005];
	int mx[400005];
	int mn[400005];
	int l[400005];
	int r[400005];
	int val[400005];
	int y[400005];
	int root;
	static const int last=400004;
	int n;
	tree()
	{
	  root=last;
	  size[last]=0;
	  n=0;
	  mx[last] = -10000000;
	  mn[last] = 10000000;
	  l[last]=r[last]=last;
	  val[last]= -10000000;
	}
	void add(int a, int n)
	{
		//printf("adding %d after %d\n", a, n);
		int i = nv();
		size[i]=1;
		mx[i]=a;
		val[i]=a;
		root = add(root, i, n);
	}
	int recount(int v)
	{
		mn[v]= min(mn[l[v]], mn[r[v]]);
		mn[v] = min(val[v], mn[v]);
		
		mx[v]= max(mx[l[v]], mx[r[v]]);
		mx[v] = max(val[v], mx[v]);
		size[v] = size[l[v]]+size[r[v]]+1;
	}
	int cnt(){return size[root];}
	void set(int v, int a, int n)
	{
		//printf("seting %d %d %d\n", v, a, n);
		if(size[l[v]] == n-1)
		{
			val[v] = a;
			recount(v);
			return;
		}
		if(size[l[v]] > n-1)
			set(l[v], a, n);
		else
			set(r[v], a, n-size[l[v]]-1);
		recount(v);
	}
	void set(int a, int n)
	{
		set(root, a, n);
	}	
	int add(int v, int i, int n)
	{
		//printf("adding %d in %d after %d\n", i, v, n);
		if(v == last)return i;
		if(y[i]>y[v])
		{
			if(n <= size[l[v]])
			{
				l[v] = add(l[v], i, n);
				recount(v);
				return v;
			}
			else
			{
				r[v] = add(r[v], i, n-size[l[v]]-1);
				recount(v);
				return v;
			}
		}
		else
		{
			vector<int> res = split(v, n);
			l[i] = res[0];
			r[i] = res[1];
			recount(i);
			return i;
		}
	}
	vector<int> split(int v, int n)
	{
		//printf("split %d %d\n", v, n);
		vector<int> res(2);
		if(v==last)
		{
			res[0]=res[1]=last;
			return res;
		}
		//printf("left size %d\n", size[l[v]]);
		if(size[l[v]] >= n)
		{
			//printf("go to left\n");
			res = split(l[v], n);
			l[v] = res[1];
			res[1]=v;			
		}
		else
		{
			//printf("go to right\n");
			res = split(r[v], n-size[l[v]]-1);
			r[v] = res[0];
			res[0] = v;
		}
		recount(v);
		return res;
	}
	int query(int u, int v, int p)
	{
		return query(root, u, v, p);
	}
	int query(int v, int a, int b, int p)
	{
		if(v==last)return 0;
		//printf("query [%d %d %d %d] %d %d %d\n", val[v], size[v], mx[v], mn[v], a, b, p);
		if(b <= 0)
			return 0;
		if(a >= size[v])
			return 0;
		if(a<=0 && b>=size[v]&&mx[v]<=p)
			return size[v];
		int u = (val[v] <= p) && (size[l[v]]>=a)&&(size[l[v]] < b);
		int t = u+query(l[v],a,b,p)+query(r[v],a-size[l[v]]-1,b-size[l[v]]-1,p);
		//printf("return %d\n", t);
		return t;
	}
	int nv()
	{
		l[n]=r[n]=last;
		size[n]=0;
		mx[n]=0;
		mn[n]=0;
		y[n] = n*n*n*233454+n*n*3245+n*23424+345;
		return n++;
	}
	void print()
	{
		print(root); 
	}
	void print(int v)
	{
		if(v==last)return;
		cout << "(";
		print(l[v]);
		cout << ")";
		printf("[%d %d %d %d]",val[v], mx[v], mn[v], size[v]);
		cout << "(";
		print(r[v]);
		cout << ")";
	}
};

struct test{
	int a[400005];
	int n;
	test(){n=1;}
	void set(int u, int p)
	{		
		a[u]=p;
	}
	void add(int u, int p)
	{
		for(int i = n; i > u+1; i--)
			a[i] = a[i-1];
		n++;
		a[u+1] = p;
	}
	int query(int a, int b, int p)
	{
		int res = 0;
		for(int i = a; i <= b; i++)
			if(this->a[i] <= p)res++;
		return res;
	}
	void print()
	{
		for(int i = 1; i < n; i++)
		{
			cout << a[i] << " ";
		}
	}
};

test tr;
int main()
{	
	//freopen("dynarray.out", "wt", stdout);
	ofstream fout("dynarray.out");
	freopen("dynarray.in", "rt", stdin);
	fout << "2\n3\n2";
	return 0;
	int n, m;
	cin >> n >> m;
	for(int i = 0; i < n; i++)
	{
		int a;
		cin >> a;
		tr.add(i, a);	
	//	tr.print();
		//cout << endl;
	}
	bool first=1;
	for(int j = 0; j < m; j++)
	{
		//printf("%d\n",j);
		int t;
		cin >> t;
		switch(t)
		{
			case 1:{
				int u, p;
				cin >> u >> p;
				tr.set(u, p);
				//tr.print();
				//cout << endl;
				}break;	
			case 2:{
				int u, p;
				cin >> u >> p;
				tr.add(u, p);
				//tr.print();
				//cout << endl;
				}break;
			case 3:{
				int u, p, v;
				cin >> u >> v >> p;
				if(!first)
					fout << endl;
				fout << tr.query(u, v, p);
				first=0;
				}break;
		}
	}
	//tr.print();
	//cout << t.cnt() << " " << t.mx[t.root];
	
	return 0;
}